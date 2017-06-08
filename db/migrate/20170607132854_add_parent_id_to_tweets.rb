class AddParentIdToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :parent_id, :integer
  end
end
