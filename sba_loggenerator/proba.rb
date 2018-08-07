require 'time'

id="#"
time = Time.new
idtime = (time.year).to_s + (time.month).to_s + (time.day).to_s + (time.hour).to_s + (time.min).to_s + (time.sec).to_s + (time.usec).to_s
                i = 0
                while i<10 do
                        rcode=rand(57)+65
                        case rcode
                                when 65..90
                                        sid=rcode.chr()
                                        id=id+sid
                                        i+=1
                                when 97..122
                                        sid=rcode.chr()
                                        id=id+sid
                                        i+=1
                        end
                end
puts idtime+id


