module TweetsHelper
    def own_tweet?(tweet)
       current_user == tweet.user
    end
    
    def get_src_tweet(tweet)
       @src_tweet = tweet.src_tweet
    end
end
