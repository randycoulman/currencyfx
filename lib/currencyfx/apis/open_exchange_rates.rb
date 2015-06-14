require_relative "../api"
require "httparty"

module Currencyfx
  module Apis
    class OpenExchangeRates < API
      include HTTParty

      base_uri "http://openexchangerates.org/api/"
      default_params app_id: ENV["OPEN_EXCHANGE_RATES_API_KEY"]

      def convert(amount, source, target)
        amount * rates[target] / rates[source]
      end

      def currency_list
        self.class.get("/currencies.json")
      end

      private

      def rates
        @rates ||= self.class.get("/latest.json")["rates"]
      end
    end
  end
end
