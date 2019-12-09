
class ModifyRowsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:country,:string
    add_column :users,:province,:string
    add_column :users,:street,:string
    add_column :users,:building,:string
    add_column :users,:unit,:string
    add_column :users,:zipcode,:string
    remove_column :users,:address1
    remove_column :users,:address2
  end
end