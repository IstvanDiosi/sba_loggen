require "rubygems"
require "elasticsearch"
require "json"



=begin

Ha jön egy log_event, akkor

   1.	A realtime enrichment-nél ha jön egy log, akkor a profiladatokat update-elni kell
   2. 	on_flight incidens-detektálni is kell	

=end



p_user_id='x3456'
p_number_of_event= 3567
p_last_connetc_ip= '11.11.11.11'
p_last_connect_time = nil
p_sba_id = '73737373'
p_device_name ='DEV0002'
p_device_rel_freq =0.555






client = Elasticsearch::Client.new host:'127.0.0.1:9200'



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






=begin <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if client.exists? index:'sba-user-profile', type:'sba-user-profile', id:p_user_id
then
#---------- update ------------------------------------------


# mint a header rekordnál inkrementálni kell MINDEN x_rel_freq-t is és persze a number_of_event-et is



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
=end <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




response = client.search index:'sba-user-profile', type:'sba-user-profile',
		body:{
			query:{match_all:{}}
			}

puts response
