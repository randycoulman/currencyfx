module Currencyfx
  RSpec.describe Currency do
    it "converts codes to strings" do
      currency = Currency.new(:USD, "United States Dollar")
      expect(currency.code).to eq("USD")
    end

    it "compares as value objects" do
      expect(Currency.new("EUR", "Euro")).to eq(Currency.new("EUR", "Euro"))
    end

    it "compares both code and description" do
      expect(Currency.new("EUR", "Euro")).not_to eq(Currency.new("EUR", "Not Euro"))
    end

    it "sorts by code then description" do
      list = [
          Currency.new("USD", "US"),
          Currency.new("EUR", "Euro"),
          Currency.new("EUR", "AAAEuro")
      ]
      expect(list.sort.map(&:description)).to eq(%w[AAAEuro Euro US])
    end

    it "fails when comparing against non-currencies" do
      expect { Currency.new("EUR", "Euro") < Object.new }.to raise_error(ArgumentError)
    end
  end
end
