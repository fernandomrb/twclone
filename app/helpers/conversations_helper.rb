module ConversationsHelper
    def participating_user(conversation)
        current_user == conversation.author ? conversation.receiver : conversation.author
    end

    def messages_count
        count = 0
        conversations = Conversation.participates(current_user)
        conversations.each do |conversation|
            count += conversation.personal_messages.unread(current_user).count
        end
        count
    end
end
