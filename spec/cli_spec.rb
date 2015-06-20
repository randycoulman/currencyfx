module Currencyfx
  RSpec.describe CLI do
    subject(:cli) { described_class.new(exchange: exchange, list_formatter: formatter) }
    let(:exchange) { instance_double(Exchange) }
    let(:formatter) { instance_double(ListFormatter) }

    before do
      allow(exchange).to receive(:convert)
      allow(exchange).to receive(:currency_list)
      allow(formatter).to receive(:format)
    end

    describe "usage message" do
      let(:arguments) { [] }

      it "lists options in the banner" do
        expect { run_cli }.to output(/\[options\]/).to_stdout
      end

      it "includes optional conversion parameters in the banner" do
        expect { run_cli }.to output(/\[amount source_currency target_currency\]/).to_stdout
      end
    end

    context "with no arguments" do
      let(:arguments) { [] }

      it "displays usage information" do
        expect { run_cli }.to output(/Usage/).to_stdout
      end

      it "exits with an error code" do
        suppress_output do
          expect { run_cli(trap_exit: false) }.to exit_with_code(1)
        end
      end
    end

    context "when exchanging currency" do
      let(:arguments) { [100, "USD", "EUR"] }
      let(:rate) { 91.87 }

      before do
        allow(exchange).to receive(:convert).with(100, "USD", "EUR") { rate }
      end

      it "displays the converted amount and currency" do
        expect { run_cli }.to output(/91.87 EUR/).to_stdout
      end

      context "when incoming amount is a string" do
        let(:arguments) { ["100", "USD", "EUR"] }

        it "converts it to a number and performs the converstion" do
          expect { run_cli }.to output(/91.87 EUR/).to_stdout
        end
      end

      context "when the converted amount has fractional cents" do
        let(:rate) { 91.86598 }

        it "rounds the converted amount to the nearest cent" do
          expect { run_cli }.to output(/91.87 EUR/).to_stdout
        end
      end

      context "when converted amount has no fractional amount" do
        let(:rate) { 91 }

        it "still displays two decimal places" do
          expect { run_cli }.to output(/91.00 EUR/).to_stdout
        end
      end
    end

    context "when asked for a currency list" do
      let(:arguments) { %w(--list) }
      let(:currency_list) { double("currency list") }

      before do
        allow(exchange).to receive(:currency_list) { currency_list }
        allow(formatter).to receive(:format).with(currency_list) { "FORMATTED LIST" }
      end

      it "displays the currency list" do
        expect { run_cli }.to output("FORMATTED LIST\n").to_stdout
      end
    end

    context "asked for both a list and a conversion" do
      let(:arguments) { [100, "USD", "EUR", "--list"] }

      it "displays the currency list" do
        suppress_output { run_cli }
        expect(exchange).to have_received(:currency_list)
      end

      it "ignores the conversion request" do
        suppress_output { run_cli }
        expect(exchange).not_to have_received(:convert)
      end
    end

    context "when not given enough arguments for conversion" do
      let(:arguments) { [100, "USD"] }

      it "displays usage information" do
        expect { run_cli }.to output(/Usage/).to_stdout
      end

      it "exits with an error code" do
        suppress_output do
          expect { run_cli(trap_exit: false) }.to exit_with_code(1)
        end
      end
    end

    context "when the exchange reports an error" do
      let(:arguments) { [100, "USD", "EUR"] }

      before do
        allow(exchange).to receive(:convert).and_raise(Exchange::Error.new("ERROR MESSAGE"))
      end

      it "prints the error message to stderr" do
        expect { run_cli }.to output(/ERROR MESSAGE/).to_stderr
      end

      it "exits with an error code" do
        suppress_error_output do
          expect { run_cli(trap_exit: false) }.to exit_with_code(2)
        end
      end
    end

    def run_cli(trap_exit: true)
      cli.run(arguments)
    rescue SystemExit
      raise unless trap_exit
    end

    def suppress_output(&block)
      expect(&block).to output.to_stdout
    end

    def suppress_error_output(&block)
      expect(&block).to output.to_stderr
    end
  end
end

RSpec::Matchers.define :exit_with_code do |expected|
  actual = nil

  match do |block|
    begin
      block.call
      return false
    rescue SystemExit => e
      actual = e.status
    end
    actual && actual == expected
  end

  failure_message do |_|
    tail = actual.nil? ? "did not exit" : "exited with code #{actual}"
    "expected block to exit with code #{expected}, but it #{tail}"
  end

  supports_block_expectations
end
