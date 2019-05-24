class TweetBroadcastJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    
    tweet.user.followers.each do |follower|
      renderer = ApplicationController.renderer_with_signed_in_user(follower)
      ActionCable.server.broadcast "timeline_#{ follower.id }",
      tweet: renderer.render(partial: "tweets/tweet", locals: { tweet: tweet })
    end
  end

end
