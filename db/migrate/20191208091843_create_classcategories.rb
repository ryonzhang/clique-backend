class CreateClasscategories < ActiveRecord::Migration[5.2]
  def change
    create_table :classcategories do |t|
      t.references :classinfo, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
