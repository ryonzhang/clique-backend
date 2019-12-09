class CreateInstitutioncategories < ActiveRecord::Migration[5.2]
  def change
    create_table :institutioncategories do |t|
      t.references :institution, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
