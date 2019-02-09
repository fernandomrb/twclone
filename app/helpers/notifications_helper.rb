module NotificationsHelper
    def notification_message(notification)
        notification.notifiable_type == "Tweet" ? "has #{notification.action} your tweet" : "#{notification.action} you"
    end
end
