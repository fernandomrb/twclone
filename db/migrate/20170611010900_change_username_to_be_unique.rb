class ChangeUsernameToBeUnique < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :username, :string, unique: true
    add_index :users, :username
  end
end
