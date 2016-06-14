require_relative 'spec_helper'

describe MyRandom do
  describe '#randomize, #get_seed_from_time' do
    10.times do
      rnd = MyRandom.randomize
      it("Randomize returned #{rnd}") {}
    end
  end

  describe '#random' do
    10.times do
      rnd = MyRandom.random
      it("Random returned #{rnd}") {}
    end
  end

  describe '#random_range' do
    context "10 < X < 10_000" do
      5.times do
        rnd = MyRandom.random_range(10, 10_000)
        it("Random returned #{rnd}") {}
      end
    end
  end

  describe '#random_prime' do
    context 'from 1 to 100' do
      5.times do
        rnd = MyRandom.random_prime(1, 100)
        it("Random returned #{rnd}") {}
      end
    end

    context 'from 2048 to 4096' do
      5.times do
        rnd = MyRandom.random_prime(2048, 4096)
        it("Random returned #{rnd}") {}
      end
    end
  end

  describe '#to_bitset' do
    context 'turns INTEGER into STRING of BITS' do
      it '255 is 00000000000011111111' do
        expect(MyRandom.to_bitset(255)).to eq "00000000000011111111"
      end

      it '3 is 00000000000000000011' do
        expect(MyRandom.to_bitset(3)).to eq "00000000000000000011"
      end
    end
  end

  describe '#rotate' do
    it 'rotate "111001" by 3 is "001111"' do
      expect(MyRandom.rotate('111001',3)). to eq '001111'
    end

    it 'rotate "111001" by 2 is "100111"' do
      expect(MyRandom.rotate('111001',2)). to eq '100111'
    end

    it 'rotate "111001" by -2 is "011110"' do
      expect(MyRandom.rotate('111001',-2)). to eq '011110'
    end
  end
end
