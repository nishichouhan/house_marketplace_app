require 'rails_helper'

RSpec.describe Property, type: :model do
  # Test associations
  describe 'associations' do
    it { should have_many(:favorites) }
    it { should have_one_attached(:image) }
  end


  describe 'image attachment' do
    it 'is valid' do
      subject.image.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpg')
      expect(subject.image).to be_attached
    end
  end
end