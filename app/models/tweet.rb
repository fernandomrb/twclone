class Tweet < ApplicationRecord
	belongs_to :user
	belongs_to :parent, class_name: "Tweet", optional: true
	has_many :replies, foreign_key: :parent_id, class_name: "Tweet"
	belongs_to :src_tweet, class_name: "Tweet", optional: true
	has_many :retweets, foreign_key: :src_tweet_id, class_name: "Tweet"
	acts_as_votable
	validates :body, presence: true, length: { maximum: 140 }

	scope :of_followed_users, -> (user) {where(user_id: user.id).or(Tweet.where(user_id: user.following)) }
	
	def get_src_tweet
		Tweet.find(self.src_tweet.id)	
	end

	def has_src_tweet?
		self.src_tweet != nil
	end

	def mentions
		@mentions ||= begin
                    regex = /@([\w]+)/
                    matches = body.scan(regex).flatten
					        end
		
	end

	def mentioned_users
    @mentioned_users ||= User.where(username: mentions)
	end

end
