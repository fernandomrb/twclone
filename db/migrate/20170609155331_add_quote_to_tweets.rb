class AddQuoteToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :quote, :text
  end
end
