FactoryBot.define do
  
  factory :user do
    sequence(:name) { |n| "User#{n} Test" }
    sequence(:email) { |n| "user#{n}@mail.com" }
    password { "12345678" }
    sequence(:username) { |n| "user#{n}" }
    
    trait :invalid_user do
      sequence(:username) { |n| "user_#{n}" }
    end
    
  end
end
