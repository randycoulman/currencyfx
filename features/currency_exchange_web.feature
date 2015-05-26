Feature: Currency Exchange (Web)
  Scenario: simple currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    And I visit the main page
    And I fill in "amount" with 100
    And I select "USD" from "source_currency"
    And I select "EUR" from "target_currency"
    When I press "Convert"
    Then the page should show "91.00 EUR"

  Scenario: reverse currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    And I visit the main page
    And I fill in "amount" with 100
    And I select "EUR" from "source_currency"
    And I select "USD" from "target_currency"
    When I press "Convert"
    Then the page should show "109.89 USD"

  Scenario: compound currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    And the exchange rate for 1 USD is 1.23 CAD
    And I visit the main page
    And I fill in "amount" with 100
    And I select "CAD" from "source_currency"
    And I select "EUR" from "target_currency"
    When I press "Convert"
    Then the page should show "73.98 EUR"
