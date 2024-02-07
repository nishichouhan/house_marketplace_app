class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites
  has_many :favorite_properties, through: :favorites, source: :property
  self.inheritance_column = :type

end
