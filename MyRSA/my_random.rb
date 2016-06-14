require_relative 'my_math'

class MyRandom
	BASE = 2										# система счисления разрядов двоичная
	SIZE = 20
	START_SEED 		= 20_010						# стартовое зерно
	@current_seed = nil	# текущее зерно

	def self.randomize
		@current_seed = get_seed_from_time
	end

	def self.random
		randomize
		r1 	= rotate(to_bitset(@current_seed), +SIZE / 5	)	# зерно, сдвинутое вправо
		r2 	= rotate(to_bitset(@current_seed), -SIZE / 5	)	# зерно, сдвинутое влево
		val = (r1.to_i(BASE) + r2.to_i(BASE))	% max_value # их сумма по модулю
		@current_seed = val 															# обновляем зерно
		return (val)
	end

	def self.random_range(from, to)
		return (random % (to - from)) + from
	end

	def self.random_prime(from = nil, to = nil)
		i = 0
		loop do
			if from
				r = random_range(from.to_i, to.to_i)
			else
				r = random
			end
			r += 1 if r % 2 == 0
			if block_given?
				next if not yield(r)
			end
			return r if MyMath.is_prime?(r)
			fail "100k tries - no primes" if i > 100_000 # endless loop break
			i += 1
		end
	end

	def self.random_condition
		return unless block_given?
		i = 0
		loop do
			r = random
			return r if yield(r)
			fail "100k tries - nope" if i > 100_000 # endless loop defense
			i += 1
		end
	end

	private

	def self.max_value
		return BASE**SIZE  # максимальное значение, которое может вернуть рандом с тек. сс и кол-вом разрядов
	end

	 # циклический сдвиг
	def self.rotate(str, count=1)
	  count	+= str.length if count < 0
	  new_left 	= str.slice(count, str.length - count)	# делим на левую и правую часть
	  new_right = str.slice(0, count)										# и меняем их местами
	  return new_left + new_right
	end

	# перевод 10 числа в число нужной СС (двоичной)
	def self.to_bitset(int)
		return int.to_s(BASE).rjust(SIZE, '0')
	end

	# получение зерна из текущего времени
	def self.get_seed_from_time
		t 	= Time.now
		y 	= t.year
		m 	= t.month
		d 	= t.day
		h 	= t.hour
		m 	= t.min
		s 	= t.sec
		ns 	= t.nsec
		seed = (y*13**6 + m*11**5 + d*7**4 + h*5**3 + m*3**2 + s + ns/100) % max_value
		# ap "seed form time = #{seed.to_s(16)}"
		# ap ns
		# ap seed
		return seed
	end
end
