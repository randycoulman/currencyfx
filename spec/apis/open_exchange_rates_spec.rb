module Currencyfx
  module Apis
    RSpec.describe OpenExchangeRates do
      subject(:api) { OpenExchangeRates.new }

      describe "converting from one currency to another",
               vcr: {
                   cassette_name: "open_exchange_rates/rates",
                   erb: { eur: 0.8, cad: 1.1 }
               } do
        it "performs a no-op conversion" do
          expect(api.convert(100, "USD", "USD")).to eq(100)
        end

        it "converts from the base currency" do
          expect(api.convert(100, "USD", "EUR")).to be_within(0.005).of(80)
        end

        it "converts to the base currency" do
          expect(api.convert(100, "EUR", "USD")).to be_within(0.005).of(125)
        end

        it "converts from one non-base currency to another" do
          expect(api.convert(100, "CAD", "EUR")).to be_within(0.005).of(72.73)
        end
      end

      describe "retrieving the currency list", vcr: { cassette_name: "open_exchange_rates/currencies" } do
        it "returns a hash of currency codes and descriptions" do
          expect(api.currency_list).to include("USD" => "United States Dollar", "EUR" => "Euro")
        end
      end
    end
  end
end
