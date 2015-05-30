require_relative "test_helper"
require "ostruct"

class OptionsText < Minitest::Test
  def setup
    super
    @options = OpenStruct.new
    @parser = OptionParser.new do |parser|
      parser.program_name = "PROGRAM"
      parser.version = "VERSION"

      parser.on("-l", "--list", "Show currency list") do |flag|
        options.show_list = flag
      end
    end
  end

  def test_help
    out, err = capture_io do
      assert_raises(SystemExit) do
        parser.parse!(%w[-h])
      end
    end

    assert_empty(err)

    assert_match(/^Usage: PROGRAM \[options\]$/, out, "output should contain usage message")
    assert_match(/^\s*-l, --list\s*Show currency list\s*$/, out, "output should describe --list option")
  end

  def test_version
    assert_output("PROGRAM VERSION\n", "") do
      assert_raises(SystemExit) do
        parser.parse!(%w[--version])
      end
    end
  end

  def test_list_flag
    parser.parse!(%w[--list])
    assert(options.show_list)
  end

  def test_short_list_flag
    parser.parse!(%w[-l])
    assert(options.show_list)
  end

  def test_non_option_args_left_behind
    args = %w[-l FOO BAR BAZ]
    parser.parse!(args)
    assert_equal(%w[FOO BAR BAZ], args)
  end

  private

  attr_reader :options, :parser
end
