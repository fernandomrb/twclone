Given(/^the following users exist:$/) do |user_list|
  user_list.hashes.each do |user|
    User.create(user)
  end
end

Given(/^the following tweets exist:$/) do |tweet_list|
  tweet_list.hashes.each do |tweet|
    User.all.each do |user|
      user.tweets.create(tweet)
      break
    end
  end
end

Then(/^I find tweet and I press "([^"]*)" button$/) do |button|
  user = User.find_by(username: "heisenberg")
  myTweet = Tweet.find_by(user_id: user.id)
  if button == "more"
    find(:xpath, "//*[@id='dropdownMenu#{myTweet.id}']").click
  elsif button == "like" or button == "retweet" or button == "reply"
    find(:css, "#tweet_#{myTweet.id} > div > div > div.footer > div > div.#{button}.col-xs-4 > button > a > div.icon-container > i").click
  end
end

Then(/^I press "([^"]*)" link$/) do |link|
  user = User.find_by(username: "heisenberg")
  myTweet = Tweet.find_by(user_id: user.id)
  find("#tweet_#{myTweet.id} > div > div > div.header > div.dropdown.open > ul > li > a", :text => link).click
end

Then(/^I confirm the dialog$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^I find some tweet and I press "([^"]*)"$/) do |action|
  user = User.find_by(username: "heisenberg")
  tweet = Tweet.where(user: user).last
  find(:xpath, "//*[@id='tweet_#{tweet.id}']/div/div/div[3]/div/div[2]/button/a")#{}"#tweet_#{tweet.id} > div > div > div.footer > div > div.#{action}.col-xs-4 > .btn-action > a").click
end

Then(/^I should see a popup window$/) do
 expect(page).to have_css("#modal-tweet")
end
