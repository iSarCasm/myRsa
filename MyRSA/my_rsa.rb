require 'base64'
require_relative 'my_random'
require_relative 'my_math'
require_relative 'block'
require_relative 'my_transport'

class MyRSA
  PRIMES_NEEDED = 10_000

  def initialize(options={})
    if options[:public]
      f = File.open(options[:public],'rb')
      data = f.read.split(" ")
      @e = data[0].to_i
      @n = data[1].to_i
    elsif options[:secret]
      f = File.open(options[:secret],'rb')
      data = f.read.split(" ")
      @d = data[0].to_i
      @n = data[1].to_i
    else
      @p = MyRandom.random_prime(Math.sqrt(2**20), Math.sqrt(2**21))
      @q = MyRandom.random_prime(Math.sqrt(2**20), Math.sqrt(2**21)) do |x|
        x != @p
      end

      puts "p = #{@p.to_s(16)}"
      puts "q = #{@q.to_s(16)}"

      @n = @p * @q
      puts "n = #{@n.to_s(16)}"

      fi = (@p - 1)*(@q - 1)
      puts "fi = #{fi.to_s(16)}"

      @e = []
      hits = 0
      loop do
        hits += 1;
        @e = MyRandom.random_range(3, fi)
        break if MyMath.gcd(@e, fi) == 1
        fail "Failed to find" if hits > PRIMES_NEEDED
      end
      @d = MyMath.euklides(@e, fi)[0]
      puts "Public key (e, n) - (#{@e}, #{@n})"
      puts "Secret key (d, n) - (#{@d}, #{@n})"
    end
  end

  def save_keys(pub, secret)
    File.open(pub, 'w') { |file| file.write("#{@e} #{@n}") }
    File.open(secret, 'w') { |file| file.write("#{@d} #{@n}") }
  end

  def encrypt(msg)
    MyMath.mod_exp(msg.to_i, @e, @n)
  end

  def decrypt(msg)
    MyMath.mod_exp(msg.to_i, @d, @n)
  end

  def encrypt_blocks(blocks)
    blocks.map do |block|
      encrypt(block)
    end
  end

  def decrypt_blocks(blocks)
    blocks.map do |block|
      decrypt(block)
    end
  end

  def encrypt_message(msg)
    blocks = Block.build(msg)
    new_blocks = encrypt_blocks(blocks)
    Block.join(new_blocks, 24)
  end

  def decrypt_message(msg)
    blocks = Block.build(msg, 24)
    new_blocks = decrypt_blocks(blocks)
    Block.join(new_blocks, 20)
  end

  def encrypt_file(file, dst="secure_data.txt")
    f = File.open(file,'rb')
    data = f.read
    enc = encrypt_message(data)
    File.open(dst, 'w') { |file| file.write(transport(enc)) }
  end

  def decrypt_file(file, dst=nil)
    f = File.open(file,'rb')
    data = f.read
    decoded = transport(data, :decode)
    msg = decrypt_message(decoded)
    if dst then
      File.open(dst, 'w') { |file| file.write(msg) }
    end
    return msg
  end

  def transport(msg, func=:encode)
		if func == :encode
			Base64.encode64(msg)
		elsif func == :decode
			Base64.decode64(msg)
		end
	end
end
