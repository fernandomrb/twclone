json.array! @users do |user|
  json.username user.username
  json.name user.name
  json.avatar user.avatar.url
  json.id user.id
end