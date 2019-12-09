class AddRowsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:first_name,:string
    add_column :users,:last_name,:string
    add_column :users,:gender,:integer
    add_column :users,:birthday,:date
    add_column :users,:address1,:string
    add_column :users,:address2,:string
    add_column :users,:city,:string
    add_column :users,:nationality,:string
    add_column :users,:phone_number,:string
    add_column :users,:emergency_name,:string
    add_column :users,:emergency_contact,:string
    add_column :users,:is_terminated,:boolean
    add_column :users,:is_searchable,:boolean
    add_column :users,:is_previous_classes_visible,:boolean
    add_column :users,:is_coming_classes_visible,:boolean
    add_column :users,:is_favorite_institutions_visible,:boolean
  end
end
