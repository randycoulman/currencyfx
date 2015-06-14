module Currencyfx
  class Currency
    include Comparable

    attr_reader :code, :description

    def initialize(code, description)
      @code = code.to_s
      @description = description
    end

    def <=>(other)
      return nil unless other.is_a?(self.class)
      (code <=> other.code).nonzero? || (description <=> other.description)
    end
  end
end
