require 'awesome_print'
require 'pry'
require_relative 'MyRSA/my_rsa'

# time_seed = MyRandom.get_seed_from_time
# ap "seed form time = #{time_seed.to_s(16)}"
# ap "and this seed in bitset is:"
# ap MyRandom.to_bitset(time_seed)
# ap "======="
# ap "number 127 to bitset = #{MyRandom.to_bitset(127)}"
# ap "number 300 to bitset = #{MyRandom.to_bitset(300)}"

# ap "======="
# x = "1100101"
# ap "#{x} << 3: #{MyRandom.rotate(x, 3)}"
# ap "#{x} >> 2: #{MyRandom.rotate(x, -2)}"

# gets

# puts "Give me smth random pls (press any key)"
# loop do
# 	ap MyRandom.random
# 	break if gets.chomp == 'c'
# end
# puts "\n"

# puts "Random Range:"
# loop do
# 	ap MyRandom.random_range(1, 228)
# 	break if gets.chomp == 'c'
# end
# puts "\n"

# puts "Random Quality Test:"
# loop do
# 	ap MyRandom.random
# 	sleep 0.2
# end
# puts "\n"

# puts "Random Quality Test:"
# loop do
# 	ap MyRandom.random
# 	sleep 0.1
# end
# puts "\n"

# puts "Conditional random: "
# ap "random | 5 : #{MyRandom.random_condition { |x| x % 5 == 0 }}"
# puts "\n"

# ap "23^11 mod 15 = #{(23**11)%15} = #{MyMath.mod_exp(23, 11, 15)}"
# ap "7^2 mod 5 = #{(7**2)%5} = #{MyMath.mod_exp(7, 2, 5)}"
# ap "6^128 mod 5 = #{(6**128)%5} = #{MyMath.mod_exp(6, 128, 5)}"
# ap "134^16 mod 5 = #{(134**16)%5} = #{MyMath.mod_exp(134, 16, 5)}"
# puts "\n"

# ap "gcd 7 and 5 = #{MyMath.gcd(7,5)}"
# ap "gcd 55 and 11 = #{MyMath.gcd(55,11)}"
# ap "gcd 10 and 110 = #{MyMath.gcd(10,110)}"
# ap "gcd 7 and 49 = #{MyMath.gcd(7,49)}"
# ap "gcd 2 and 4 = #{MyMath.gcd(2,4)}"

# ap "Euklides Algh.:"
# puts "7d - 20y = 1;\t #{MyMath.euklides(7, 20)}\n"
# puts "3d - 8y = 1;\t #{MyMath.euklides(3, 8)}\n"
# puts "39d - 13y = 1;\t #{MyMath.euklides(39, 13)}\n"
#

# ap "Lehman Prime Test:"
# for i in 1..1 do
# 	x = MyRandom.random % 100 + 1
# 	puts "is #{x} prime?\t #{MyMath.is_prime?(x)}"
# end

# ap "Get Random Prime"
# loop do
# 	ap MyRandom.random_prime
# 	break if gets.chomp == 'c'
# end
# puts "\n"

rsa = MyRSA.new
rsa.encrypt_file('src.txt')
ap rsa.decrypt_file('secure_data.txt', 'dst.txt')

# ap "My RSA:"
# 100.times do
#   rsa = MyRSA.new
#   ap rsa
#   msg = 'lllllllllll aaaaaaa lll'
#   enc = rsa.encrypt_message(msg)
#   dec = rsa.decrypt_message(enc)
#   ap msg
#   ap enc
#   ap dec
#   # dec.each_with_index { |x, i| ap x == msg[i] }
#   binding.pry
# end
