require_relative 'MyRSA/my_rsa'

puts "===MyRSA (Igor Tsykalo)==="
puts "DECRYPTION"
puts "Relative path to secret keys file (enter - secretkeys.txt):"
k = gets
if k == "\n" then
  k = "#{File.dirname(__FILE__)}/files/secretkeys.txt"
else
  k = "#{File.dirname(__FILE__)}/files/#{k.chomp}"
end
rsa = MyRSA.new(secret: k)

puts "Relative path to encrypted file (enter - encrypted.txt):"
f = gets
if f == "\n" then
  f = "#{File.dirname(__FILE__)}/files/encrypted.txt"
else
  f = "#{File.dirname(__FILE__)}/files/#{f.chomp}"
end
puts "Destination file (enter - decrypted.txt):"
dst = gets
if dst == "\n" then
  dst = "#{File.dirname(__FILE__)}/files/decrypted.txt"
else
  dst = "#{File.dirname(__FILE__)}/files/#{dst.chomp}"
end
puts rsa.decrypt_file(f, dst)
puts "Decryption seccessful!"
