Given(/^the following users exist:$/) do |user_list|
  user_list.hashes.each do |user|
    User.create(user)
  end
end