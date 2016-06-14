class MyTransport
  def self.encode(msg)
    source_blocks = msg.scan(/.{1}/)
    encoded_blocks = source_blocks.map do |block|
      binary_block  = to_binary(block)
      left_bytes    = binary_block[0..3]
      right_bytes   = binary_block[4..7]
      left    = left_bytes.to_i(2).to_s(16)
      right   = right_bytes.to_i(2).to_s(16)
      left + right
    end
    encoded_blocks.join
  end

  def self.decode(msg)
    source_blocks = msg.scan(/.{2}/)
    decoded_blocks = source_blocks.map do |block|
      left    = block[0]
      right   = block[1]
      left_bin    = left.to_i(16).to_s(2).rjust(4,'0')
      right_bin   = right.to_i(16).to_s(2).rjust(4,'0')
      (left_bin << right_bin).to_i(2).chr
    end
    res = decoded_blocks.join
    puts res
    res
  end

  private

  def self.to_binary(char)
    char.ord.to_s(2).rjust(8,'0')
  end
end
