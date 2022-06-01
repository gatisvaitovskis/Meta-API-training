Feature: Location

  Scenario: Create new location
    Given prepare auth token
    Then user creates new location
    And user updates location
    Then user delete location
    And user list all locations
