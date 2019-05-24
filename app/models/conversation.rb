class Conversation < ApplicationRecord
    # after_save { |conversation| conversation.destroy if conversation.personal_messages.empty? }
    belongs_to :author, class_name: "User"
    belongs_to :receiver, class_name: "User"
    has_many :personal_messages, -> { order(created_at: :asc) }, dependent: :destroy
    scope :participates, -> (user) { where(author: user).or(where(receiver: user)) }
    scope :between, -> (author, receiver) { where(author: author, receiver: receiver).or(where(author: receiver, receiver: author)) }

    def opposed_user(user)
        user == author ? receiver : author
    end

    def participates?(user)
        author == user || receiver == user
    end
end
