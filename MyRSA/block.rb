class Block
	def self.build_raw(msg, bits_size=20)
		block_list = []
		bitset = ''
		msg.split('').each do |char|
			bitset += to_bitset(char.ord)		# переводим все символы в 8-битный код, и соединяем вместе
		end
		bitset += '0' * ((bits_size - bitset.size % bits_size) % bits_size) # дополняем до кратности
		block_list = bitset.scan(/.{#{bits_size}}/)													# делим результат, на массив частей по bits_size бит
	end

	def self.build(msg, bits_size=20)
		blocks = build_raw(msg, bits_size)
		blocks.map! do |block|
			block.to_i(2)	# делаем из массива бит массив чисел
		end
	end

	def self.join(blocks, bits_size=20)
		bit_blocks = blocks.map do |block|
			to_bitset(block, bits_size)	# соединяем в одну последовательность бит
		end
		bitset = bit_blocks.join
		chars = bitset.scan(/.{8}/)		# делим на байты
		chars.map! do |c|
			c.to_i(2).chr								# переводим обратно в символы
		end.join
	end

	def self.to_bitset(int, base=8)
		return int.to_s(2).rjust(base, '0') # перевод числа в 8 битное слово
	end
end
