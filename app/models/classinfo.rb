class Classinfo < ApplicationRecord
  has_many :feedbacks
  has_many :sessions
  has_many :classtags
  has_many :tags ,through: :classtags
  has_many :classcategories
  has_many :categories ,through: :classcategories
  has_many :userclasses
  has_many :users, through: :userclasses
  belongs_to :institution
end
