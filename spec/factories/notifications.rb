FactoryBot.define do
  factory :notification do
    recipient_id { 1 }
    actor_id { 2 }
    read_at { "2019-01-20 11:17:48" }
    action { "liked" }
    notifiable_id { 1 }
    notifiable_type { "Like" }
  end
end
