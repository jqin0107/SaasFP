Feature: User edit

  As a user, I should be able to edit my user info and logout

Background: users in database and tester1 logged in

  Given the following users exist:
  | user_name    | first_name | last_name | password |
  | tester1      | tfn1       | tln1      | abcdefgh |
  | tester2      | tfn2       | tln2      | 12345678 |
  Then I go to the login page
  And  I fill in "Username" with "tester1"
  And  I fill in "Password" with "abcdefgh"
  And  I press "Login"

Scenario: edit first name
  When I go to the welcome page
  Then I follow "Go to User profile"
  Then I should see "tfn1"
  Then I follow "Edit"
  Then I should be on the edit page for "tester1"
  Then I fill in "First Name" with "Tester1 First Name"
  Then I press "Update Profile"
  Then I should see "Tester1 First Name"

Scenario: edit password
  When I go to the welcome page
  Then I follow "Go to User profile"
  Then I follow "Edit"
  Then I should be on the edit page for "tester1"
  Then I fill in "Password" with "newpassword"
  Then I press "Update Profile"
  Then I go to the login page
  And  I fill in "Username" with "tester1"
  And  I fill in "Password" with "newpassword"
  And  I press "Login"
  Then I should be on the home page

Scenario: Logout
  When I go to the welcome page
  Then I follow "Go to User profile"
  Then I follow "Logout"
  Then I should be on the login page
