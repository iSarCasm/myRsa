require_relative 'MyRSA/my_rsa'

def test_random_randomize
  puts "Жмите Enter, чтобы получить очередное случайное зерно:"
  loop do
   	print MyRandom.get_seed_from_time
   	break if gets != "\n"
  end
end

def test_random
  puts "Жмите Enter, чтобы получить очередное случайное число:"
  loop do
   	print MyRandom.random
   	break if gets != "\n"
  end
end

def test_random_range
  puts "Минимум:"
  min = gets.chomp.to_i
  puts "Максимум:"
  max = gets.chomp.to_i
  puts "Жмите Enter, чтобы получить очередное случайное число:"
  loop do
   	print MyRandom.random_range(min, max)
   	break if gets != "\n"
  end
end

def test_random_prime
  puts "Жмите Enter, чтобы получить очередное случайное простое:"
  loop do
   	print MyRandom.random_prime
   	break if gets != "\n"
  end
end

def test_random_prime_range
  print "Минимум: "
  min = gets.chomp.to_i
  print "Максимум: "
  max = gets.chomp.to_i
  puts "Жмите Enter, чтобы получить очередное случайное простое:"
  loop do
    puts MyRandom.random_prime(min, max)
    break if gets != "\n"
  end
end

def test_gcd
  print "A:"
  a = gets.chomp.to_i
  print "B:"
  b = gets.chomp.to_i
  puts "GCD(A, B) = #{MyMath.gcd(a,b)}"
end

def test_modexp
  puts "a^m mod n"
  print "a: "
  a = gets.chomp.to_i
  print "m: "
  m = gets.chomp.to_i
  print "n: "
  n = gets.chomp.to_i
  puts "a^m mod n = #{MyMath.mod_exp(a, m, n)}"
end

def test_prime
  print "Введите число: "
  x = gets.chomp.to_i
  puts "#{x} - простое? Ответ: #{MyMath.is_prime?(x)}"
end

def test_euklides
  puts "a * d - b * y = 1"
  print "a: "
  a = gets.chomp.to_i
  print "b: "
  b = gets.chomp.to_i
  puts "#{a}d - #{b}y = 1;\t #{MyMath.euklides(a, b)}\n"
end

def test_rsa
  puts "Введите число для кодирования:"
  a = gets.chomp.to_i
  rsa = MyRSA.new
  b = rsa.encrypt(a)
  print "Зашифрованное число: "
  puts b
  print "Расшифруем обратно: "
  puts rsa.decrypt(b)
end

def test_transport_enc
  print "Введите строку для кодирования: "
  z = gets.chomp
  puts MyTransport.encode(z)
end

def test_transport_dec
  puts "Длина строки кратна 2, состоит из символов 0-f"
  puts "Введите строку для декодирования:"
  z = gets.chomp
  puts MyTransport.decode(z)
end


puts "Меню тестирования:"
puts "
  1 - Randomize класса MyRandom
  2 - Random (случайное число)
  3 - Random Range (случайное число в переделах)
  4 - Random Prime (случайное простое число)
  5 - Random Range Prime (случайное простое в пределах)
  6 - GCD, НОД
  7 - ModExp (модульное возведение в степень)
  8 - Тест на простоту Лемана
  9 - Алгоритм Евклида
  10 - Транспортное кодирование
  11 - Транспортное декодирование
  12 - Алгоритм RSA
"
option = gets.chomp
case option
when "1"
  test_random_randomize
when "2"
  test_random
when "3"
  test_random_range
when "4"
  test_random_prime
when "5"
  test_random_prime_range
when "6"
  test_gcd
when "7"
  test_modexp
when "8"
  test_prime
when "9"
  test_euklides
when "10"
  test_transport_enc
when "11"
  test_transport_dec
when "12"
  test_rsa
else
  puts "Ошибка выбора!"
end
