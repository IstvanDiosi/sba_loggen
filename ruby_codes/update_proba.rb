require "rubygems"
require "elasticsearch"
require "json"



p_user_id='x12345'
p_client_device_id=''



client = Elasticsearch::Client.new host:'127.0.0.1:9200'


if client.exists? index:'sba-user-profile', type:'user', id:p_user_id
then

	puts " ----------------- update van -------------------------"
	#---------- update --------------------------------------------------------
	# kiolvasom a létező rekordot és áttöltöm a releváns változótartalmakat
	#--------------------------------------------------------------------------
	response = client.search index:'sba-user-profile', type:'user',
                body:{
                        query:{match:{_id:p_user_id}}
                        }

	response 	= response.to_json
	parsed_response = JSON.parse(response)

	puts parsed_response
       
	#------ áttöltés ---------------------------------------------------------
	result 			= parsed_response["hits"]["hits"][0]["_source"]
	p_number_of_event 	= parsed_response["hits"]["hits"][0]["_source"]["number_of_event"]

	puts "p_number_of_event  ---> #{p_number_of_event}"

        puts " ----------------- update következik -------------------------"

	p_number_of_event+=1	

	#-------- update ---------------------------------------------------------
	 client.update index:'sba-user-profile', type:'user', id:p_user_id,
		body:{ doc: {
				number_of_event:p_number_of_event
                            }
		      }			
			


else
#---------- insert ------------------------------------------
 client.index index:'sba-user-profile', type:'user', id:p_user_id,
                body:{
                         number_of_event:1
                      }
end

