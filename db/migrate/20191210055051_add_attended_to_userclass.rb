class AddAttendedToUserclass < ActiveRecord::Migration[5.2]
  def change
    add_column :userclasses, :attended, :boolean
  end
end
