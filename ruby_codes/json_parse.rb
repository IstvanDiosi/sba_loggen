require "json"

geoip ={  
   "timezone":"Europe/Amsterdam",
   "ip":"23.9.208.123",
   "latitude":52.35,
   "coordinates":[  
      4.9167,
      52.35
   ],
   "continent_code":"EU",
   "city_name":"Amsterdam",
   "country_code2":"NL",
   "country_name":"Netherlands",
   "country_code3":"NL",
   "region_name":"North Holland",
   "location":[  
      4.9167,
      52.35
   ],
   "postal_code":"1091",
   "longitude":4.9167,
   "region_code":"NH"
   }


response	= geoip

response        = response.to_json
parsed_response = JSON.parse(response)

puts parsed_response

=begin
{"timezone"=>"Europe/Amsterdam", "ip"=>"23.9.208.123", "latitude"=>52.35, "coordinates"=>[4.9167, 52.35], "continent_code"=>"EU", "city_name"=>"Amsterdam", "country_code2"=>"NL", "country_name"=>"Netherlands", "country_code3"=>"NL", "region_name"=>"North Holland", "location"=>[4.9167, 52.35], "postal_code"=>"1091", "longitude"=>4.9167, "region_code"=>"NH"}
=end


#------ áttöltés ---------------------------------------------------------
timezone             	= parsed_response["timezone"]
ip	             	= parsed_response["ip"]
latitude		= parsed_response["latitude"]
longitude		= parsed_response["longitude"] 
continent_code          = parsed_response["continent_code"]
city_name          	= parsed_response["city_name"]
country_name		= parsed_response["country_name"]

puts timezone
puts ip
puts latitude
puts longitude	
puts continent_code
puts city_name
puts country_name






