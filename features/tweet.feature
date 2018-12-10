Feature: manage tweets
Background: 
  Given the following users exist:
  | name            | email                       | username          | password   |
  | Walter White    | walterwhite@gmail.com       | heisenberg        | ZgXUUSKD   |
  | Saul Goodman    | bettercallsaul@gmail.com    | slippinjimmy      | gFVMLBvR   |
  | Jesse Pinkman   | jessepinkman@gmail.org      | capncook          | TryWBV6b   |
  Then I am on the home page 
  When I fill in "user_login" with "heisenberg"
  And I fill in "user_password" with "ZgXUUSKD"
  And I press "Log in"
  Then I should see "Signed in successfully."
  
Scenario: Should be able to create a new tweet
  Given I am on the home page
  And I press button "#navbar-collapse-1 > ul.nav.navbar-nav.navbar-right > li.btn-tweet > a"
  Then I fill in "tweet_body" with "Qualis est is lascivio venatus."
  When I press "tweet"
  Then I should see "Qualis est is lascivio venatus."
  
  
  