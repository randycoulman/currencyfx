Given(/^the exchange rate for ([\d.]+) ([A-Z]{3}) is ([\d.]+) ([A-Z]{3})$/) do |source_amount, source_currency, dest_amount, dest_currency|
  pending
end

Given(/^the following currencies exist:?$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I convert ([\d.]+) from ([A-Z]{3}) to ([A-Z]{3})$/) do |amount, source, target|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should get ([\d.]+) ([A-Z]{3})$/) do |amount, currency|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I ask for a currency list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see currencies and descriptions in this order:$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end
