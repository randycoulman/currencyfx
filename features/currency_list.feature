Feature: Currency List
  Show the list of supported currencies in alphabetical order
  by currency symbol.

  Scenario: currency list
    Given the following currencies exist:
      | symbol | description |
      | USD    | United States Dollars |
      | CAD    | Canadian Dollars |
      | EUR    | European Union Euros |
    When I ask for a currency list
    Then I should see currencies and descriptions in this order:
      | symbol | description |
      | CAD    | Canadian Dollars |
      | EUR    | European Union Euros |
      | USD    | United States Dollars |

