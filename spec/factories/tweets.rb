FactoryGirl.define do
  factory :tweet do
    body "Gus sit amet suum motum. Nescio quando, aut quomodo, nescio quo."
    association :user, :factory => :user
  end
end
