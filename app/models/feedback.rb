class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :classinfo
  belongs_to :institution
end
