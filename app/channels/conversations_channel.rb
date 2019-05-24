class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    conversation = Conversation.find_by(id: data['conversation_id'])
    if conversation && conversation.participates?(current_user)
      personal_message = current_user.personal_messages.build({body: data['message']})
      personal_message.conversation = conversation
      personal_message.save!
    end
  end
end
