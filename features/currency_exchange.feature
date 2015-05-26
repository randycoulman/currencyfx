Feature: Currency Exchange
  Allow the exchange of amounts of money from one
  currency to another.

  Scenario: basic currency exchange
    Given the exchange rate for 1 USD is 0.91 EUR
    When I convert 100 from USD to EUR
    Then I should get 91.00 EUR
