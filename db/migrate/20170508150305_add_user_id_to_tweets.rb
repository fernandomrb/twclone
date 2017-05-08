class AddUserIdToTweets < ActiveRecord::Migration[5.1]
  def change
  	change_table :tweets do |t|
  		t.integer :user_id
  	end
  end
end
