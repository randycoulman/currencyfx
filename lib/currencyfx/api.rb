module Currencyfx
  class API
    def convert(amount, source, target)
      fail NotImplementedError, "Subclasses must implement this"
    end

    def currency_list
      fail NotImplementedError, "Subclasses must implement this"
    end
  end
end
