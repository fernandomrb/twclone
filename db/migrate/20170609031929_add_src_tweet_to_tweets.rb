class AddSrcTweetToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :src_tweet_id, :integer
  end
end
