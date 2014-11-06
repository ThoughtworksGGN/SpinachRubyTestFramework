@smoke
Feature: Smoke Tests

  @javascript
  Scenario: Login
    Given I access Yahoo search page
    When I search for ThoughtWorks
    And I submit search
    Then I should see first link as ThoughtWorks