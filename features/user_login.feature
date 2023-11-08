Feature: User login

  As a user, I should be able to login to my account

Background: users in database

  Given the following users exist:
  | user_name  | first_name | last_name | password |
  | user1      | uu         | ul1       | aaa      |
  | user2      | bb         | ul2       | 12345678 |

Scenario: don't login to user
  When I go to the welcome page
  Then I should be on the login page

Scenario: try to edit without login
  When I go to the edit page for "user1"
  Then I should be on the login page

Scenario: try to see activities without login
  When I go to the home page
  Then I should be on the login page

Scenario: login to user
  When I go to the login page
  And  I fill in "Username" with "user1"
  And  I fill in "Password" with "aaa"
  And  I press "Login"
  Then I should be on the home page

Scenario: wrong password
  When I go to the login page
  And  I fill in "Username" with "user2"
  And  I fill in "Password" with "randompassword"
  And  I press "Login"
  Then I should be on the login page