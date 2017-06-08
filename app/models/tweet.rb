class Tweet < ApplicationRecord
	belongs_to :user
	belongs_to :parent, class_name: "Tweet", optional: true
	has_many :replies, foreign_key: :parent_id, class_name: "Tweet"
	acts_as_votable
	validates :body, presence: true, length: { maximum: 140 }

	scope :of_followed_users, -> (user) {where(user_id: user.id).or(Tweet.where(user_id: user.following)) }

end
