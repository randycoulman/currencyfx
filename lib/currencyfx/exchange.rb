require_relative "api"
require_relative "currency"

module Currencyfx
  class Exchange
    class Error < RuntimeError; end

    def initialize(api:)
      @api = api
    end

    def convert(amount, source, target)
      api.convert(amount, source, target)
    end

    def currency_list
      api.currency_list.each_with_object([]) do |(code, description), memo|
        memo << Currency.new(code, description)
      end.sort
    end

    private

    attr_reader :api
  end
end
