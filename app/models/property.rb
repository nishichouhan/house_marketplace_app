class Property < ApplicationRecord
  has_many :favorites	
  has_one_attached :image
  validates :property_type, inclusion: { in: ['residential'], message: "can only be residential" }
end
