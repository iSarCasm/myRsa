module MyMath
  LEHMANN_TESTS = 16

 	def self.gcd(x, y)
 		loop do
	 		if x > y
	 			x, y = y, x % y
	 		else
	 			x, y = x, y % x
	 		end
	 		break if y == 0
	 	end
 		return x
 	end

 	def self.mod_exp(a, m, n)
    begin
   		p = 1
   		mi = a % n
   		size = Math.log2(m).floor + 1
   		for i in 0...size
   			bi = m.to_s(2).reverse[i].to_i
   			if bi != 0
   				p = (p*mi) % n
   			end
   			mi = (mi*mi) % n
        # puts "i = #{i}\t bi = #{bi}\t p = #{p}\t mi = #{mi}"
   		end
   		return p
    rescue
      puts "ERROR: a:#{a} m:#{m} n:#{n}"
    end
 	end

  def self.euklides(a, b)
    i = 2
    # STEP 0
    r_0 = a
    d_0 = 1
    y_0 = 0
    # STEP 1
    r_1 = b
    d_1 = 0
    y_1 = 1
    loop do
      # DO
      r_2 = r_0 % r_1
      d_2 = d_0 + (r_0/r_1).to_i * d_1
      y_2 = y_0 + (r_0/r_1).to_i * y_1
      # CHECK
      if r_2 == 0
        if i % 2 == 1
          return [d_1, y_1]
        else
          return [d_2 - d_1, y_2 - y_1]
        end
      end
      # INCREMENT
      i += 1
      r_0 = r_1; r_1 = r_2
      d_0 = d_1; d_1 = d_2
      y_0 = y_1; y_1 = y_2
    end
  end

  def self.is_prime?(val)
    LEHMANN_TESTS.times do
      a = MyRandom.random_range(1, val - 1)
      x = mod_exp(a, ((val - 1) / 2), val)
      if x == 1 || x == (val-1)
        next
      else
        return false
      end
    end
    return true
  end
 end
