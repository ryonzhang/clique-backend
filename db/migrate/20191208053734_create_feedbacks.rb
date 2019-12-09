class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.integer :star_num
      t.text :comment
      t.references :user, foreign_key: true
      t.references :institution, foreign_key: true
      t.references :classinfo, foreign_key: true
      t.timestamps
    end
  end
end
