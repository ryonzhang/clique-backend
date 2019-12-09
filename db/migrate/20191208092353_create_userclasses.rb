class CreateUserclasses < ActiveRecord::Migration[5.2]
  def change
    create_table :userclasses do |t|
      t.references :user, foreign_key: true
      t.references :classinfo , foreign_key: true

      t.timestamps
    end
  end
end
