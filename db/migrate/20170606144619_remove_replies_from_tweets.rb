class RemoveRepliesFromTweets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tweets, :replies, :integer
  end
end
