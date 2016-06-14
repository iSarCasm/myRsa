class MyTransport
  def self.encode(msg)
    source_blocks = block(msg, 1) # берем по 1 байту
    encoded_blocks = source_blocks.map do |block|
      binary_block  = to_binary(block)        # переводим в 8 битное слово
      left_bytes    = binary_block[0..3]      # первые 4 бита
      right_bytes   = binary_block[4..7]      # последние 4 бита
      left    = left_bytes.to_i(2).to_s(16)   # переводим в 16 символ 0-F
      right   = right_bytes.to_i(2).to_s(16)  # переводим в 16 символ 0-F
      left + right # объединяем 2 символа, т.о из 1 символа получаем 2
    end
    encoded_blocks.join # соединяем результат в строку
  end

  def self.decode(msg)
    source_blocks = block(msg ,2) # берем по 2 символа сразу
    decoded_blocks = source_blocks.map do |block|
      left    = block[0] # первый символ
      right   = block[1] # второй символ
      left_bin    = left.to_i(16).to_s(2).rjust(4,'0')  # переводим в 4 битное слово
      right_bin   = right.to_i(16).to_s(2).rjust(4,'0') # переводим в 4 битное слово
      (left_bin << right_bin).to_i(2).chr # соединяем и переводим в 8 битное слово (символ)
    end
    decoded_blocks.join # соединяем результат в строку
  end

  private

  def self.to_binary(char)
    char.ord.to_s(2).rjust(8,'0')
  end

  def self.block(data,block_size) # разбивает строку на массив строк по block_size символов
		block_count = data.size / block_size;
		blocks = Array.new
		for i in 0...block_count do
		  blocks[i] = data[(i*block_size...(i+1)*block_size)]
		end
		return blocks
	end
end
