module ConversationsHelper
    def participating_user(conversation)
        current_user == conversation.author ? conversation.receiver : conversation.author
    end
end
