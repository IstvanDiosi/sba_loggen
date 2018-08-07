require "rubygems"
require "elasticsearch"
require "json"

p_user_id=20
p_number_of_event= 123
p_last_connetc_ip= '10.10.10.10'
p_last_connect_time = nil
p_sba_id = 'lakslakslakslkalskals'
p_device_name ='DEV0001'
p_device_rel_freq =0.3423






client = Elasticsearch::Client.new host:'127.0.0.1:9200'



#---------- insert ------------------------------------------
 client.index index:'sba-user-profile', type:'sba-user-profile', id:p_user_id,
                body:{
                     	 number_of_event:p_user_id,
			 last_connect_ip:p_last_connetc_ip,
			 last_connect_time:p_last_connect_time,
			 sba_id:p_sba_id,
			 client_device:[{
							device_name:p_device_name,
							device_rel_freq:p_device_rel_freq
						   }]			
                      }







response = client.search index:'sba-user-profile', type:'sba-user-profile',
		body:{
			query:{match_all:{}}
			}

puts response
