class Tweet < ApplicationRecord
	belongs_to :user
	acts_as_votable
	validates :body, presence: true, length: { maximum: 140 }

	scope :of_followed_users, -> (user) {where(user_id: user.id).or(Tweet.where(user_id: user.following)) }

end
