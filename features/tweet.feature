Feature: manage tweets
Background: 
  Given the following users exist:
  | name            | email                       | username          | password   |
  | Walter White    | walterwhite@gmail.com       | heisenberg        | ZgXUUSKD   |
  | Saul Goodman    | bettercallsaul@gmail.com    | slippinjimmy      | gFVMLBvR   |
  | Jesse Pinkman   | jessepinkman@gmail.org      | capncook          | TryWBV6b   |
  And the following tweets exist:
  | body                                    |
  | Nonne vides quid sit? Tu es             |
  | Jesse me respice. Tu ... blowfish sunt. |
  | A blowfish! Cogitare. Statura pusillus. |
  Then I am on the home page 
  When I fill in "user_login" with "heisenberg"
  And I fill in "user_password" with "ZgXUUSKD"
  And I press "Log in"
  Then I should see "Signed in successfully."
  
Scenario: Should be able to create a new tweet
  Given I am on the home page
  Then I fill in "tweet_body" with "Qualis est is lascivio venatus."
  When I press "tweet"
  Then I should see "Qualis est is lascivio venatus."
@javascript
Scenario: Should be able to create a new tweet from modal
  Given I am on the home page
  And I press button "#navbar-collapse-1 > ul.nav.navbar-nav.navbar-right > li.btn-tweet > a"
  Then I should see a popup window
  Then I fill in "tweet_body" with "Poof. Vir aetatis operantes, dura sicut facit ..."
  When I press button "#modal-tweet input"
  Then I should see "Poof. Vir aetatis operantes, dura sicut facit ...."
@javascript
Scenario: Should be able to edit my own tweet
  Given I am on the home page
  And I find tweet and I press "more" button
  And I press "Edit" link
  Then I should see a popup window
  And I fill in "tweet_body" with "Ego intervenerit."
  When I press button ".tweeting"
  Then I should see "Your tweet has been updated."

@javascript
Scenario: Should be able to delete my own tweet
  Given I am on the home page
  Then I find tweet and I press "more" button
  When I press "Delete" link
  Then I confirm the dialog
  Then I should see "Your tweet has been deleted."

@javascript
Scenario: Should be able to retweet a tweet
  Given I am on the home page
  When I find some tweet and I press "retweet"
  Then I should see a popup window
  And I fill in "tweet_quote" with "Yes, I can retweet a tweet"
  When I press button ".tweeting"
  Then I should see "Yes, I can retweet a tweet"
