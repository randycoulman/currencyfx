require "stringio"
require "terminal-table"

module Currencyfx
  class ListFormatter
    def format(currency_list)
      Terminal::Table.new do |t|
        t.headings = %w[Code Description]
        t.rows = currency_list.map { |c| [c.code, c.description] }
      end
    end
  end
end
