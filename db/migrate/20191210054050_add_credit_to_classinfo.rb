class AddCreditToClassinfo < ActiveRecord::Migration[5.2]
  def change
    add_column :classinfos, :credit, :integer
  end
end
