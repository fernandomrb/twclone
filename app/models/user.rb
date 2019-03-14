class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include PgSearch
  searchkick text_start: [:name, :username]

  pg_search_scope :search_by_name_and_username, against: [:name, :username], 
                  using: {
                    tsearch: { prefix: true }
                  }

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  has_many :tweets

  acts_as_voter

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :notifications, foreign_key: "recipient_id"
  
  has_many :authored_conversations, class_name: "Conversation", foreign_key: "author_id"
  has_many :received_conversations, class_name: "Conversation", foreign_key: "receiver_id"

  has_many :personal_messages, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 20 }
  validates :username, presence: true, length: { in: 5..15 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }, uniqueness: true
  validates :bio, length: { maximum: 160 }

  def follow(user_id)  
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
  
   def retweet_it?(tweet)
     if tweet.retweets.find_by(user_id: self.id)
       return true
     end
     return false
   end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  def has_notifications?
    self.notifications.any?
  end

end
