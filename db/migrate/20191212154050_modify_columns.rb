class ModifyColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :classinfos,:is_available
    remove_column :classinfos,:bookable_before
    remove_column :classinfos,:bookable_after
    add_column :classinfos,:days_in_between,:integer
  end
end