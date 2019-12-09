class CreateClassinfos < ActiveRecord::Migration[5.2]
  def change
    create_table :classinfos do |t|
      t.datetime :time
      t.integer :duration_in_min
      t.string :name
      t.integer :level
      t.text :general_info
      t.text :preparation_info
      t.integer :arrival_ahead_in_min
      t.text :additional_info
      t.integer :vacancies
      t.boolean :is_available
      t.datetime :bookable_before
      t.datetime :bookable_after

      t.timestamps
    end
  end
end
