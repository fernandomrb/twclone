class PersonalMessage < ApplicationRecord
  after_commit { MessageBroadcastJob.perform_later(self) }
  belongs_to :conversation
  belongs_to :user

  scope :unread, -> (user) { where(read_at: nil).where.not(user: user) }

  validates :body, presence: true
end
