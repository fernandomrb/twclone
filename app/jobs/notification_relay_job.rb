class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", 
    message: notification.notifiable_type == "Tweet" ? "has #{notification.action} your tweet" : "follow you",
    user: notification.actor
    end
end
