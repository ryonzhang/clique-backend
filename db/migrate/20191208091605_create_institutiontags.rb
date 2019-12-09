class CreateInstitutiontags < ActiveRecord::Migration[5.2]
  def change
    create_table :institutiontags do |t|
      t.references :institution, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
