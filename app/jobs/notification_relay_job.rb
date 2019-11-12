class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", 
    message: ["liked", "replied", "retweet"].include?(notification.notifiable_type) ? "has #{notification.action} your tweet" : "#{notification.action} you",
    user: notification.actor
    end
end
