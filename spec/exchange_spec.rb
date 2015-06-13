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
  end
end
