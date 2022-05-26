Feature: Location

  Scenario: Create new location
    Given user is authorized
    Then user creates new location
    And user updates location
    Then  user delete location
    And under list all locations