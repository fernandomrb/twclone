class Notification < ApplicationRecord
    after_commit -> { NotificationRelayJob.perform_later(self) }
    
    belongs_to :recipient, class_name: "User"
    belongs_to :actor, class_name: "User"
    belongs_to :notifiable, polymorphic: true

    validates :recipient_id, presence: true
    validates :actor_id, presence: true
    validates :action, presence: true
    validates :notifiable_id, presence: true
    validates :notifiable_type, presence: true

    scope :unread, -> { where(read_at: nil)}

    def self.send_notification(recipient, actor, action, notifiable)
        Notification.create(recipient: recipient, actor: actor, action: action, notifiable: notifiable)
    end
end
