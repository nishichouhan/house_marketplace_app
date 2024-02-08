class Property < ApplicationRecord
  has_many :favorites	
  has_one_attached :image
  enum city: {
    taipei: "Taipei",
    new_taipei: "New Taipei",
  }
end
