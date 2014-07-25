@smoke
Feature: Smoke Tests

  @javascript
  Scenario: Post comments
    Given I access page that have comment form
    When I enter comment author as Pulkit
    And I enter commentor email as acbg@fgs.com
    And I enter comment
    Then I should see my comment is awaiting moderation