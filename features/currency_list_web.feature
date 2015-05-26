Feature: Currency List (Web)
  Scenario: currency list
    Given the following currencies exist:
      | symbol | description |
      | USD    | United States Dollars |
      | CAD    | Canadian Dollars |
      | EUR    | European Union Euros |
    And I visit the main page
    And I click the "supported_currencies" link
    Then the page should show "CAD"
    And the page should show "Canadian Dollars"
    And the page should show "Eur"
    And the page should show "European Union Euros"
    And the page should show "USD"
    And the page should show "United States Dollars"
