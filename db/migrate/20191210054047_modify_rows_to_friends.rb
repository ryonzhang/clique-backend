
class ModifyRowsToFriends < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships,:friend_id
    add_reference :friendships, :friend, references: :users, index: true

    add_foreign_key :friendships, :users, column: :friend_id
  end
end