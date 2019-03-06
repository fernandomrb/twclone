class PersonalMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  scope :unread, -> (user) { where(read_at: nil).where.not(user: user) }
end
