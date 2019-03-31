class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @notifications = Notification.where(recipient: current_user).order(created_at: "DESC")
        @notifications_count = notifications_count
        mark_as_read(@notifications.unread)
    end

    protected

    def mark_as_read(notifications)
        notifications.update_all(read_at: Time.now)
    end 
end
