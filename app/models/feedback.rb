class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :classinfo
  belongs_to :institution
  belongs_to :session
end
