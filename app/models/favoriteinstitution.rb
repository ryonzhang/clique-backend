class Favoriteinstitution < ApplicationRecord
  belongs_to :user
  belongs_to :institution
end
