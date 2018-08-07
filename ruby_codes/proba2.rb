require "rubygems"
require "elasticsearch"
require "json"



=begin

Ha jön egy log_event, akkor

   1.	A realtime enrichment-nél ha jön egy log, akkor a profiladatokat update-elni kell
   2. 	on_flight incidens-detektálni is kell	

=end



p_user_id='x3456'
p_number_of_event= 3333
p_last_connetc_ip= '22.22.22.22'
p_last_connect_time = nil
p_sba_id = '73737373'
p_device_name ='DEV0003'
p_device_rel_freq_new =0.11111



client = Elasticsearch::Client.new host:'127.0.0.1:9200'


if client.exists? index:'sba-user-profile', type:'sba-user-profile', id:p_user_id
then

	puts " ----------------- update van -------------------------"
	#---------- update --------------------------------------------------------
	# kiolvasom a létező rekordot és áttöltöm a releváns változótartalmakat
	#--------------------------------------------------------------------------
	response = client.search index:'sba-user-profile', type:'sba-user-profile',
                body:{
                        query:{match:{_id:p_user_id}}
                        }

	response 	= response.to_json
	parsed_response = JSON.parse(response)

	puts parsed_response["hits"]["hits"][0]["_source"]
       
	#------ áttöltés ---------------------------------------------------------
	result 			= parsed_response["hits"]["hits"][0]["_source"]
	p_number_of_event 	= parsed_response["hits"]["hits"][0]["_source"]["number_of_event"]
 	p_last_connect_ip 	= parsed_response["hits"]["hits"][0]["_source"]["last_connect_ip"]
	p_sba_id	  	= result["sba_id"]
	p_device_name		= result["client_device"][0]["device_name"]
	p_device_rel_freq	= result["client_device"][0]["device_rel_freq"]



	puts "p_number_of_event  ---> #{p_number_of_event}"
	puts "p_last_connect_ip  ---> #{p_last_connect_ip}"
	puts "p_device_name      ---> #{p_device_name}"
	puts "p_device_rel_freq  ---> #{p_device_rel_freq}"

        puts " ----------------- update következik -------------------------"
	

	#-------- update ---------------------------------------------------------
	 client.update index:'sba-user-profile', type:'sba-user-profile', id:p_user_id,
		body:{ script: {
				inline:'ctx._source.client_device += AddClientDevice',
				params:{AddClientDevice:[{device_name:p_device_name,
							  device_rel_freq:p_device_rel_freq_new
                                                        }]
                                        },
				lang:'groovy'
				}			
			}


else
#---------- insert ------------------------------------------
 client.index index:'sba-user-profile', type:'sba-user-profile', id:p_user_id,
                body:{
                         number_of_event:p_number_of_event,
                         last_connect_ip:p_last_connetc_ip,
                         last_connect_time:p_last_connect_time,
                         sba_id:p_sba_id,
                         client_device:[{
                                        device_name:p_device_name,
                                        device_rel_freq:p_device_rel_freq
                                                   }]
                      }



end

