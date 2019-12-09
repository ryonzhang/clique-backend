class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.decimal :star_num
      t.integer :feedback_count
      t.text :general_info
      t.string :country
      t.string :province
      t.string :city
      t.string :street
      t.string :building
      t.string :unit
      t.string :zipcode
      t.decimal :latitude
      t.decimal :longitude
      t.text :location_instruction

      t.timestamps
    end
  end
end
