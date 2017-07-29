require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))


Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end
Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, :with => value) 
end

# When(/^I confirm (.+)$/) do
#   page.accept_confirm do
#     click_link 'Delete'
#   end
# end

When /^(?:|I )press button "([^"]*)"$/ do |selector|
  find(:css, selector).click
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

Then /^I should see "([^"]*)"$/ do |message|
  page.has_content?(message)
end

When(/^I clicked on "(.*?)" link within "(.*?)"$/) do |link, container|
  within(container) do
    click_link(link)
  end
end

When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end