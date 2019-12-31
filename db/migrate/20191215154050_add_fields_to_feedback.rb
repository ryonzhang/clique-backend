class AddFieldsToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_reference :feedbacks, :session, references: :sessions, index: true
  end
end
