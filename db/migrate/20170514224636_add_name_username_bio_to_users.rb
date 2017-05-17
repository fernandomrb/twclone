class AddNameUsernameBioToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string, unique: true
    add_column :users, :bio, :text
  end
end
