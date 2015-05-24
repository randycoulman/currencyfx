Feature: Currency Exchange
  Scenario: simple currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    When I run "currencyfx 100 --from USD --to EUR"
    Then I should see "100 USD => 91 EUR"

  Scenario: reverse currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    When I run "currencyfx 100 --from EUR --to USD"
    Then I should see "100 EUR => 109.89 USD"

  Scenario: compound currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    And the exchange rate for 1 USD is 1.23 CAD
    When I run "currencyfx 100 --from CAD --to EUR"
    Then I should see "100 CAD => 73.98 EUR"
