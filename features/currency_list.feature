Feature: Currency List
  Show the list of supported currencies in alphabetical order
  by currency symbol.

  Scenario: currency list
    When I ask for a currency list
    Then I should see currencies and descriptions in this order:
      | symbol | description |
      | CAD    | Canadian Dollar |
      | EUR    | Euro |
      | USD    | United States Dollar |
