Feature: User registeration

  As a new user, I should be able to register a new account

Background: users in database

  Given the following users exist:
  | user_name    | first_name | last_name | password |
  | u1           | f1         | l1        | abcdefgh |
  | u2           | f2         | l2        | 12345678 |

Scenario: register new user
  When I go to the register page
  And  I fill in "Username" with "tester3"
  And  I fill in "First Name" with "f3"
  And  I fill in "Last Name" with "l3"
  And  I fill in "Password" with "tstpwd3"
  And  I press "Register"
  Then I should be on the home page

Scenario: register new user with duplicated user name
  When I go to the register page
  And  I fill in "Username" with "u1"
  And  I fill in "First Name" with "f1"
  And  I fill in "Last Name" with "l1"
  And  I fill in "Password" with "pwd1"
  And  I press "Register"
  Then I should be on the register page