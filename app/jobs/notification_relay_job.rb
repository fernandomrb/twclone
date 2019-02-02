class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
			ActionCable.server.broadcast "notifications:#{notification.recipient_id}", message: "You have a new notification"
  end
end
