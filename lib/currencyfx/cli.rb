require_relative "exchange"
require_relative "list_formatter"
require_relative "apis/open_exchange_rates"

require "optparse"
require "ostruct"

module Currencyfx
  class CLI
    def self.run(args = ARGV)
      self.new.run(args)
    end

    def initialize(exchange: Exchange.new(api: DEFAULT_API), list_formatter: ListFormatter.new)
      @options = Options.new
      @exchange = exchange
      @list_formatter = list_formatter
    end

    def run(args = ARGV)
      parse_arguments(args)
      unless options.valid?
        puts option_parser
        exit(1)
      end

      if options.show_list
        show_list
      else
        convert(options.amount, options.source_currency, options.target_currency)
      end
    rescue Exchange::Error => e
      $stderr.puts(e.message)
      exit(2)
    end

    private

    DEFAULT_API = Apis::OpenExchangeRates.new

    attr_reader :options, :exchange, :list_formatter

    def parse_arguments(args)
      option_parser.parse!(args)
      options.amount, options.source_currency, options.target_currency = *args
    end

    def show_list
      puts list_formatter.format(exchange.currency_list)
    end

    def convert(amount, source_currency, target_currency)
      converted = exchange.convert(Float(amount), source_currency, target_currency)
      printf("%.2f %s => %.2f %s\n", amount, source_currency, converted, target_currency)
    end

    def option_parser
      @option_parser ||= OptionParser.new do |parser|
        parser.banner = "Usage: #{parser.program_name} [options] [amount source_currency target_currency]"
        parser.version = Currencyfx::VERSION

        parser.on("-l", "--list", "Show currency list") do |flag|
          options.show_list = flag
        end
      end
    end

    class Options < OpenStruct
      def valid?
        show_list || has_conversion_arguments?
      end

      private

      def has_conversion_arguments?
        amount && source_currency && target_currency
      end
    end
  end
end
