class CreateUsersessions < ActiveRecord::Migration[5.2]
  def change
    create_table :usersessions do |t|
      t.references :user, foreign_key: true
      t.references :session, foreign_key: true

      t.timestamps
    end
  end
end
