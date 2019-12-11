class AddNameToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :name, :string
  end
end
