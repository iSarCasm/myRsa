require 'base64'
require_relative 'my_random'
require_relative 'my_math'
require_relative 'block'
require_relative 'my_ui'

class MyRSA
  PRIMES_NEEDED = 10_000

  def initialize(d = nil, n = nil)
    if d && n
      @d = d
      @n = n
    else
      @p = MyRandom.random_prime(Math.sqrt(2**20), Math.sqrt(2**21))
      @q = MyRandom.random_prime(Math.sqrt(2**20), Math.sqrt(2**21)) do |x|
        x != @p
      end

      ap "p = #{@p.to_s(16)}"
      ap "q = #{@q.to_s(16)}"

      @n = @p * @q
      ap "n = #{@n.to_s(16)}"

      fi = (@p - 1)*(@q - 1)
      ap "fi = #{fi.to_s(16)}"

      @e = []
      hits = 0
      loop do
        hits += 1;
        @e = MyRandom.random_range(3, fi)
        break if MyMath.gcd(@e, fi) == 1
        fail "Failed to find" if hits > PRIMES_NEEDED
      end
      ap "e = #{@e.to_s(16)}"
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
    # ap "Source blocks:"
    # ap blocks
    new_blocks = encrypt_blocks(blocks)
    # ap "Encrypted blocks:"
    # ap new_blocks
    Block.join(new_blocks, 24)
  end

  def decrypt_message(msg)
    blocks = Block.build(msg, 24)
    # ap blocks
    new_blocks = decrypt_blocks(blocks)
    # ap new_blocks
    Block.join(new_blocks, 20)
  end

  def encrypt_file(file, dst="secure_data.txt")
    f = File.open(file,'rb')
    data = f.read
    enc = encrypt_message(data)
    # ap "Encrypted string:"
    # ap enc
    File.open(dst, 'w') { |file| file.write(transport(enc)) }
  end

  def decrypt_file(file, dst=nil)
    f = File.open(file,'rb')
    data = f.read
    decoded = transport(data, :decode)
    # ap "Decoded string:"
    # ap decoded
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
