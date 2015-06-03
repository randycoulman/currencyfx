Given(/^the exchange rate for ([\d.]+) ([A-Z]{3}) is ([\d.]+) ([A-Z]{3})$/) do |source_amount, source_currency, dest_amount, dest_currency|
  #pending
end

Given(/^the following currencies exist:?$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  #pending # Write code here that turns the phrase above into concrete actions
end

When(/^I convert ([\d.]+) from (\w{3}) to (\w{3})$/) do |amount, source, target|
  @output = run_application(amount, source, target)
end

Then(/^I should get ([\d.]+) (\w{3})$/) do |amount, currency|
  expect(@output).to match /#{amount} #{currency.upcase}/
end

When(/^I ask for a currency list$/) do
  @output = run_application("--list")
end

Then(/^I should see currencies and descriptions in this order:$/) do |table|
  expected_output = table.raw[1..-1].map { |row| row.join("\\s+|\\s+") }.join("\\s+|\\n|\\s+")
  expect(@output).to match /#{expected_output}/m
end

def run_application(*args)
  %x(bin/currencyfx #{args.join(" ")})
end
