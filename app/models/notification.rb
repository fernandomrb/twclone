class Notification < ApplicationRecord
    belongs_to :recipient, class_name: "User"
    belongs_to :actor, class_name: "User"
    belongs_to :notifiable, polymorphic: true

    validates :recipient_id, presence: true
    validates :actor_id, presence: true
    validates :action, presence: true
    validates :notifiable_id, presence: true
    validates :notifiable_type, presence: true
end
