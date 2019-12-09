class AddInstitutionToClassinfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :classinfos, :institution, foreign_key: true
  end
end
