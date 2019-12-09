class CreateFavoriteinstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :favoriteinstitutions do |t|
      t.references :user, foreign_key: true
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
