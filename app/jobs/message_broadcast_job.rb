class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(personal_message)
    ActionCable.server.broadcast "conversations_#{personal_message.user.id}",
                                  message: render_message(personal_message, personal_message.user),
                                  conversation_id: personal_message.conversation.id
    opossed_user = personal_message.conversation.opposed_user(personal_message.user)
    ActionCable.server.broadcast "conversations_#{opossed_user.id}",
                                  message: render_message(personal_message, opossed_user),
                                  conversation_id: personal_message.conversation.id

  end
 
  def render_message(message, user)
    renderer = ApplicationController.renderer_with_signed_in_user(user.id)
    renderer.render(partial: "conversations/personal_message", locals: { personal_message: message, current_user: user })
  end
end
