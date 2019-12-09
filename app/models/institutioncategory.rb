class Institutioncategory < ApplicationRecord
  belongs_to :institution
  belongs_to :category
end
