Feature: Currency List
  Scenario: currency list
    Given the following currencies exist:
      | symbol | description |
      | USD    | United States Dollars |
      | CAD    | Canadian Dollars |
      | EUR    | European Union Euros |
    When I run "currencyfx --list"
    Then I should see
    """
    | Symbol | Description           |
    ==================================
    | CAD    | Canadian Dollars      |
    | EUR    | European Union Euros  |
    | USD    | United States Dollars |
    """
