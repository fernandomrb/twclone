module TweetsHelper
    def own_tweet?(tweet)
       current_user == tweet.user
    end
    
    def get_src_tweet(tweet)
       @src_tweet = tweet.src_tweet
    end

    def linked_users(body)
      body.gsub /@([\w]+)/ do |match|
         link_to match, profile_user_path($1)
      end.html_safe
    end

end
