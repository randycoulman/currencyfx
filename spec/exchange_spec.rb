module Currencyfx
  RSpec.describe Exchange do
    subject(:exchange) { described_class.new(api: api) }
    let(:api) { instance_double(API) }

    describe "converting currency amounts" do  # MENTION WHY THIS ISN'T `describe "#convert"`
      it "forwards conversion requests directly to the API" do
        expect(api).to receive(:convert).with(100, "USD", "EUR")
        exchange.convert(100, "USD", "EUR")
      end

      it "returns the converted amount directly from the API" do
        allow(api).to receive(:convert) { 42.00 }
        expect(exchange.convert(100, "USD", "EUR")).to equal(42.00)
      end
    end

    describe "retrieving a currency list" do
      let(:api_result) do
        {
            USD: "United States Dollar",
            CAD: "Canadian Dollar",
            EUR: "Euro"
        }
      end
      let(:list) { exchange.currency_list }

      before do
        allow(api).to receive(:currency_list) { api_result }
      end

      it "converts the returned Hash into an array of currencies" do
        expected = [
            Currency.new("USD", "United States Dollar"),
            Currency.new("CAD", "Canadian Dollar"),
            Currency.new("EUR", "Euro")
        ]
        expect(list).to match_array(expected)
      end

      it "sorts the array by currency code" do
        expect(list.map(&:code)).to eq(%w[CAD EUR USD])
      end
    end
  end
end
