require_relative 'MyRSA/my_rsa'

puts "===MyRSA (Igor Tsykalo)==="
puts "Generate new keys (enter - yes)?"
generate = gets
if generate = "\n" then
  rsa = MyRSA.new
else

end
