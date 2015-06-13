require_relative "api"

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
      fail "Test-drive this!"
    end

    private

    attr_reader :api
  end
end
