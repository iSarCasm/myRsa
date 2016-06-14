require_relative 'MyRSA/my_rsa'

puts "===MyRSA (Igor Tsykalo)==="
puts "ENCCRYPTION"
puts "Generate new keys (enter - yes)?"
generate = gets
if generate == "\n" then
  rsa = MyRSA.new
  puts "Where to save genrated public keys (enter = pubkeys.txt)?"
  p = gets
  if p == "\n" then
    p = "#{File.dirname(__FILE__)}/files/pubkeys.txt"
  else
    p = "#{File.dirname(__FILE__)}/files/#{p.chomp}"
  end
  puts "Where to save genrated secret keys (enter = secretkeys.txt)?"
  s = gets
  if s == "\n" then
    s = "#{File.dirname(__FILE__)}/files/secretkeys.txt"
  else
    s = p.chomp
  end
  rsa.save_keys(p, s)
else
  puts "Relative path to public keys file (enter - pubkeys.txt):"
  file = gets
  if file == "\n" then
    file = "#{File.dirname(__FILE__)}/files/pubkeys.txt"
  else
    file = "#{File.dirname(__FILE__)}/files/#{file.chomp}"
  end
  rsa = MyRSA.new(public: file)
end

puts "Relative path to file to encrypt (enter - source.txt):"
file = gets
puts "Name ecnrypted file (enter - encrypted.txt):"
dst = gets
if file == "\n" then
  file = "#{File.dirname(__FILE__)}/files/source.txt"
else
  file = "#{File.dirname(__FILE__)}/files/#{file.chomp}"
end
if dst == "\n" then
  dst = "#{File.dirname(__FILE__)}/files/encrypted.txt"
else
  dst = "#{File.dirname(__FILE__)}/files/#{dst.chomp}"
end
rsa.encrypt_file(file, dst)

puts "File encrypted successfuly!"
