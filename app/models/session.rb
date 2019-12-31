class Session < ApplicationRecord
  belongs_to :classinfo
  has_many :usersessions
  has_many :users, through: :usersessions
end