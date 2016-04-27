require_relative 'my_random'
require_relative 'my_math'
require_relative 'my_ui'

class MyRSA
  PRIMES_NEEDED = 100_000

  def initialize(d = nil, n = nil)
    if d && n
      @d = d
      @n = n
    else
      @p = MyRandom.random_prime
      @q = MyRandom.random_prime

      @n = @p * @q

      fi = (@p - 1)*(@q - 1)

      @e = []
      for x in 1...@n do
        MyUI.progress("Looking for prime pair", PRIMES_NEEDED, @e.size)
        if MyMath.gcd(x, fi) == 1
          @e << x
          break if @e.size > PRIMES_NEEDED
        end
      end
      puts "\n"
      @e = @e.sample

      @d = MyMath.euklides(@e, fi)[0]
      ap "Public key (e, n) - (#{@e}, #{@n})"
      ap "Secret key (d, n) - (#{@d}, #{@n})"
    end
  end

  def encrypt(msg)
    MyMath.mod_exp(msg.to_i, @e, @n)
  end

  def decrypt(msg)
    MyMath.mod_exp(msg.to_i, @d, @n)
  end
end
