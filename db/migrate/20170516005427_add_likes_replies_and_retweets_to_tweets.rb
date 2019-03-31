class AddLikesRepliesAndRetweetsToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :likes, :int
    add_column :tweets, :replies, :int
    add_column :tweets, :retweets, :int
  end
end
