class Institutiontag < ApplicationRecord
  belongs_to :institution
  belongs_to :tag
end
