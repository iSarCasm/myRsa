require_relative 'spec_helper'

describe 'Block' do
  describe '.build_raw' do
    context 'returns array of 20 bit blocks' do
      it 'is an Array' do
        expect(Block.build_raw('2456')).to be_an Array
      end

      it '"2456" size of elements is 20 bit' do
        blocks = Block.build_raw('2456')
        expect(blocks).to satisfy do |b|
          b.all? do |block|
            block.size % 20 == 0
          end
        end
      end

      it '"12" size of elements is 20 bit' do
        blocks = Block.build_raw('2456')
        expect(blocks).to satisfy do |b|
          b.all? do |block|
            block.size % 20 == 0
          end
        end
      end
    end
  end

  describe '.join' do
    it 'does opposite to .build' do
      blocks = Block.build('12345678901234567890')
      expect(Block.join(blocks)).to eq '12345678901234567890'
      expect(Block.build(Block.join(blocks))).to eq blocks
    end

    it 'does opposite to .build2' do
      blocks = Block.build('12')
      # expect(Block.join(blocks)).to eq '1234'
      expect(Block.build(Block.join(blocks))).to eq blocks
    end
  end
end
