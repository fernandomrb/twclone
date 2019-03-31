class RemoveRetweetsColumnFromTweets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tweets, :retweets
  end
end
