require_relative 'MyRSA/my_rsa'
path = ENV["OCRA_EXECUTABLE"] || __FILE__

puts "===MyRSA (Igor Tsykalo)==="
puts "ENCCRYPTION"
puts "Generate new keys (enter - yes)?"
generate = gets
if generate == "\n" then
  rsa = MyRSA.new
  puts "Where to save genrated public keys (enter = pubkeys.txt)?"
  p = gets
  if p == "\n" then
    p = "#{path}/../files/pubkeys.txt"
  else
    p = "#{path}/../files/#{p.chomp}"
  end
  puts "Where to save genrated secret keys (enter = secretkeys.txt)?"
  s = gets
  if s == "\n" then
    s = "#{path}/../files/secretkeys.txt"
  else
    s = p.chomp
  end
  rsa.save_keys(p, s)
else
  puts "Relative path to public keys file (enter - pubkeys.txt):"
  file = gets
  if file == "\n" then
    file = "#{path}/../files/pubkeys.txt"
  else
    file = "#{path}/../files/#{file.chomp}"
  end
  rsa = MyRSA.new(public: file)
end

puts "Relative path to file to encrypt (enter - source.txt):"
file = gets
puts "Name ecnrypted file (enter - encrypted.txt):"
dst = gets
if file == "\n" then
  file = "#{path}/../files/source.txt"
else
  file = "#{path}/../files/#{file.chomp}"
end
if dst == "\n" then
  dst = "#{path}/../files/encrypted.txt"
else
  dst = "#{path}/../files/#{dst.chomp}"
end
rsa.encrypt_file(file, dst)

puts "File encrypted successfuly!"
