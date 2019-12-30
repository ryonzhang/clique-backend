class AddFieldsToClassinfo < ActiveRecord::Migration[5.2]
  def change
    add_column :classinfos, :min_age, :integer
    add_column :classinfos, :max_age, :integer
  end
end
