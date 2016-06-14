require_relative 'spec_helper'

describe MyMath do
  describe '#gcd' do
    context 'returns greatest common devider of X and Y' do
      it("gcd(15,10) = 5") { expect(MyMath.gcd(15,10)).to eq 5 }
      it("gcd(27,9) = 9") { expect(MyMath.gcd(27,9)).to eq 9 }
      it("gcd(13,11) = 1") { expect(MyMath.gcd(13,11)).to eq 1 }
      it("gcd(27,4) = 1") { expect(MyMath.gcd(27,4)).to eq 1 }
      it("gcd(121,33) = 11") { expect(MyMath.gcd(121,33)).to eq 11 }
      it("gcd(777,543) = 3") { expect(MyMath.gcd(777,543)).to eq 3 }
      it("gcd(202,505) = 101") { expect(MyMath.gcd(202,505)).to eq 101 }
      it("gcd(583895,957395) = 5") { expect(MyMath.gcd(583895,957395)).to eq 5 }
      it("gcd(2,2) = 2") { expect(MyMath.gcd(2,2)).to eq 2 }
      it("gcd(1,9) = 1") { expect(MyMath.gcd(1,9)).to eq 1 }
    end
  end

  describe '#mod_exp' do
    context 'returns (a^m)%n' do
      it "23^11 mod 15 = #{(23**11)%15}" do
        expect(MyMath.mod_exp(23, 11, 15)).to eq((23**11)%15)
      end

      it "7^2 mod 5 = #{(7**2)%5}" do
        expect(MyMath.mod_exp(7, 2, 5)).to eq((7**2)%5)
      end

      it "6^128 mod 5 = #{(6**128)%5}" do
        expect(MyMath.mod_exp(6, 128, 5)).to eq((6**128)%5)
      end

      it "134^16 mod 5 = #{(134**16)%5}" do
        expect(MyMath.mod_exp(134, 16, 5)).to eq((134**16)%5)
      end
    end
  end

  describe '#euklides' do
    it '7d - 20y = 1; Answer is [3,1]' do
      expect(MyMath.euklides(7, 20)).to eq [3,1]
    end

    it '3d - 8y = 1; Answer is [3,1]' do
      expect(MyMath.euklides(3, 8)).to eq [3,1]
    end

    it '39d - 13y = 1; Answer is [1,2]' do
      expect(MyMath.euklides(39, 13)).to eq [1,2]
    end
  end

  describe '#is_prime' do
    primes = 10
    loop do
      rnd = Random.rand(100_000_000)
      rnd += 1 if rnd % 2 == 0
      if Prime.prime? rnd then
        it("#{rnd} should be prime") { expect(MyMath.is_prime?(rnd)).to eq true }
        primes -= 1
      end
      break if primes == 0
    end

    composites = 5
    loop do
      rnd = Random.rand(100_000_000)
      rnd += 1 if rnd % 2 == 0
      unless Prime.prime? rnd then
        it("#{rnd} should NOT be prime") { expect(MyMath.is_prime?(rnd)).to eq false }
        composites -= 1
      end
      break if composites == 0
    end
  end
end
