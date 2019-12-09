# app/models/user.rb
class User < ApplicationRecord

  ROLES = %i[admin partner consumer]
  # encrypt password
  has_secure_password

  # Model associations
  has_many :todos, foreign_key: :created_by
  # Validations
  validates_presence_of  :email, :password_digest

  has_many :invites
  has_many :feedbacks
  has_many :favoriteinstitutions
  has_many :institutions, through: :favoriteinstitutions
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :invites
  has_many :intended_friends, through: :invites
  has_many :userclasses
  has_many :classinfos, through: :userclasses


end