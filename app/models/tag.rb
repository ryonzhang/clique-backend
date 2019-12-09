class Tag < ApplicationRecord
  has_many :classtags
  has_many :classinfos ,through: :classtags
  has_many :institutiontags
  has_many :institutions ,through: :institutiontags
end
