module NotificationsHelper
    def notification_message(notification)
        set_message(notification.notifiable_type, notification.action, notification.notifiable_id)
    end

    def set_message(type, action, id)
        return "#{action} your #{ link_to 'tweet', tweet_path(id), remote: true }".html_safe if action == "liked"
        return "has #{action} your #{ link_to 'tweet', tweet_path(id), remote: true }".html_safe if action == "retweet" && action == "replied"
        return "#{ action } you" if action == "follows"
        return "has #{ link_to 'mention', tweet_path(id), remote: true } you".html_safe if action == "mentioned"
      end
end
