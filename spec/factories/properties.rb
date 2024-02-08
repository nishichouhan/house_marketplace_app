FactoryBot.define do
  factory :property do
    property_type { "residential" }
    city { "Taipei" }
    district { "Example District" }
    bedrooms { 2 }
    rent_per_month { "1200.50" }
    mrt_line { "Example MRT Line" }
    description { "A lovely property with convenient access to public transport." }
    net_size { "650" } # Assuming this is square feet or a similar unit
    
    after(:build) do |property|
      property.image.attach(io: File.open(Rails.root.join('spec/support/assets/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpg')
    end
  end
end