class Institution < ApplicationRecord
  has_many :feedbacks
  has_many :institutiontags
  has_many :tags ,through: :institutiontags
  has_many :institutioncategories
  has_many :categories ,through: :institutioncategories
  has_many :favoriteinstitutions
  has_many :users, through: :favoriteinstitutions
  has_many :classinfos
end
