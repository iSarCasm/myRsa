require_relative 'MyRSA/my_rsa'

path = ENV["OCRA_EXECUTABLE"] || __FILE__

puts "===MyRSA (Igor Tsykalo)==="
puts "DECRYPTION"
puts "Relative path to secret keys file (enter - secretkeys.txt):"
k = gets
if k == "\n" then
  k = "#{path}/../files/secretkeys.txt"
else
  k = "#{path}/../files/#{k.chomp}"
end
rsa = MyRSA.new(secret: k)

puts "Relative path to encrypted file (enter - encrypted.txt):"
f = gets
if f == "\n" then
  f = "#{path}/../files/encrypted.txt"
else
  f = "#{path}/../files/#{f.chomp}"
end
puts "Destination file (enter - decrypted.txt):"
dst = gets
if dst == "\n" then
  dst = "#{path}/../files/decrypted.txt"
else
  dst = "#{path}/../files/#{dst.chomp}"
end
puts rsa.decrypt_file(f, dst)
puts "Decryption seccessful!"
