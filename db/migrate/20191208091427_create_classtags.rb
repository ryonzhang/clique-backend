class CreateClasstags < ActiveRecord::Migration[5.2]
  def change
    create_table :classtags do |t|
      t.references :classinfo, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
