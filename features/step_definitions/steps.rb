require_relative "../support/vcr"
require "currencyfx"

Given(/^the exchange rate for 1 USD is ([\d.]+) ([A-Z]{3})$/) do |dest_amount, dest_currency|
  default_rates = { eur: 1.0, cad: 1.0 }
  @cassette_options = { erb: default_rates.merge(dest_currency.downcase.to_sym => dest_amount) }
end

When(/^I convert ([\d.]+) from (\w{3}) to (\w{3})$/) do |amount, source, target|
  VCR.use_cassette("open_exchange_rates/rates", @cassette_options) do
    @output = run_application(amount, source, target)
  end
end

Then(/^I should get ([\d.]+) (\w{3})$/) do |amount, currency|
  expect(@output).to match /#{amount} #{currency.upcase}/
end

When(/^I ask for a currency list$/) do
  VCR.use_cassette("open_exchange_rates/currencies") do
    @output = run_application("--list")
  end
end

Then(/^I should see currencies and descriptions in this order:$/) do |table|
  expected_output = table.raw[1..-1].map { |row| row.join("\\s+\\|\\s+") }.join("\\s+\\|.*\\|\\s+")
  expect(@output).to match(/#{expected_output}/m)
end

def run_application(*args)
  capture_output { Currencyfx::CLI.run(args) }
end

def capture_output
  original_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure
  $stdout = original_stdout
end
