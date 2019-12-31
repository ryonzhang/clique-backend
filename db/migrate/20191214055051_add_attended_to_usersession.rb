class AddAttendedToUsersession < ActiveRecord::Migration[5.2]
  def change
    add_column :usersessions, :attended, :boolean
  end
end
