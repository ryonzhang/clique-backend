class AddRowsToUsers2 < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:username,:string

  end
end