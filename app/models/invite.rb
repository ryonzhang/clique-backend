class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :intended_friend, :class_name => 'User'
end
