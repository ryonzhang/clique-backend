
class ModifyRowsToInvites < ActiveRecord::Migration[5.2]
  def change
    remove_column :invites,:intended_friend_id
    add_reference :invites, :intended_friend, references: :users, index: true

    add_foreign_key :invites, :users, column: :intended_friend_id
  end
end