class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.references :user, foreign_key: true
      t.references :intended_friend, foreign_key: true, references: :users
      t.integer :status

      t.timestamps
    end
  end
end
