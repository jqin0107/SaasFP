Feature: custmize your schedule

  As an officer at Columbia University
  So that I can post new events
  I want to add details about the event I post

Background: events in database

  Given the following events exist:
  | title     | location | tag              |   date       |
  | Event1    | Mudd     | Computer Science |   2023-11-25 |
  | Event2    | NWC      | Speech           |   2023-11-26 |
  | Event3    | Uris     | Business         |   2023-11-25 |
  | Event4    | Lerner   | Career Fair      |   2023-11-11 |

Given the following users exist: 
| user_name    | first_name | last_name | password |
| aaa          | bbb        | ccc       | ddd      |
| eee          | fff        | ggg       | hhh      |

Scenario: Log in to my user page
  When I go to the login page
  And  I fill in "Username" with "aaa"
  And  I fill in "Password" with "ddd"
  And  I press "Login"
  Then I should see "Event Board"

Scenario: create new events with tags
  When I go to the login page
  And  I fill in "Username" with "aaa"
  And  I fill in "Password" with "ddd"
  And  I press "Login"
  When I go to the new event page
  Then I should see "Create New Event"
  And  I fill in "Location" with "Mudd"
  And  I fill in "Title" with "New events"
  And  I press "Save Changes"
  Then the location of "New events" should be "Mudd"

Scenario: update existing events 
  When I go to the login page
  And  I fill in "Username" with "aaa"
  And  I fill in "Password" with "ddd"
  And  I press "Login"
  When I go to the event edit page for "Event1"
  And  I fill in "Location" with "Lerner"
  And  I press "Update Event Info"
  Then the location of "Event1" should be "Lerner"

Scenario: delete event
  When I go to the login page
  And  I fill in "Username" with "aaa"
  And  I fill in "Password" with "ddd"
  And  I press "Login"
  Given I am on the details page for "Event1"
  And   I follow "Delete"
  Then  I should be on the home page

  Scenario: Edit and leave some empty fields
    When I go to the login page
    And  I fill in "Username" with "aaa"
    And  I fill in "Password" with "ddd"
    And  I press "Login"
    When I go to the event edit page for "Event1"
    And  I fill in "Location" with ""
    And  I press "Update Event Info"
    Then the location of "Event1" should be "Lerner"