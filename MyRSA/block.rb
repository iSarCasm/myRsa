class Block
	def self.build_raw(msg, bits_size=20)
		block_list = []
		bitset = ''
		msg.split('').each do |char|
			bitset += to_bitset(char.ord)
		end
		bitset += '0' * ((bits_size - bitset.size % bits_size) % bits_size)
		block_list = bitset.scan(/.{#{bits_size}}/)
	end

	def self.build(msg, bits_size=20)
		blocks = build_raw(msg, bits_size)
		blocks.map! do |block|
			block.to_i(2)
		end
	end

	def self.join(blocks, bits_size=20)
		bit_blocks = blocks.map do |block|
			z = to_bitset(block, bits_size)
			# ap z.size
			# ap z
			# ap block
			z
		end
		bitset = bit_blocks.join
		chars = bitset.scan(/.{8}/)
		chars.map! do |c|
			c.to_i(2).chr
		end.join
	end

	def self.to_bitset(int, base=8)
		return int.to_s(2).rjust(base, '0')
	end
end
