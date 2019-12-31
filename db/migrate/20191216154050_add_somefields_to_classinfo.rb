class AddSomefieldsToClassinfo < ActiveRecord::Migration[5.2]
  def change
    add_column :classinfos, :instructor, :string
    add_column :classinfos, :endtime, :datetime
  end
end
