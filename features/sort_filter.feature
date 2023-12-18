Feature: custmize your schedule

  As an officer at Columbia University
  So that I can post new events
  I want to add details about the event I post

Background: events in database

  Given the following events exist:
  | title     | location | tag              |   date        | open_status |
  | AEvent1    | Mudd     | Computer Science |   2023-11-25 |    Close    |
  | BEvent2    | NWC      | Speech           |   2023-12-26 |    Open     |
  | CEvent3    | Uris     | Business         |   2023-12-25 |    Open     |
  | DEvent4    | Lerner   | Career Fair      |   2023-11-11 |    Close    |

Given the following users exist: 
| user_name    | first_name | last_name | password |
| aaa          | bbb        | ccc       | ddd      |
| eee          | fff        | ggg       | hhh      |

Then I go to the login page
And  I fill in "Username" with "aaa"
And  I fill in "Password" with "ddd"
And  I press "Login"

Scenario: sort events alphabetically
    And  I follow "Event Name"
    Then I should see "AEvent1" before "BEvent2"

Scenario: sort movies in increasing order of release date
    When I follow "Date"
    Then I should see "DEvent4" before "CEvent3"

Scenario: all categories unchecked
    Then I uncheck the following tags: Computer Science, Speech, Business, Career Fair, Others
    And I press "Refresh"
    Then I should see all the events

