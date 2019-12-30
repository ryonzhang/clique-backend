class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.datetime :time
      t.integer :duration_in_min
      t.integer :vacancies
      t.references :classinfo, foreign_key: true
      t.timestamps
    end
  end
end
