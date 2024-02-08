require 'yaml'

# Load YAML configuration file
config_path = Rails.root.join('config', 'config.yml')
config = YAML.safe_load(File.read(config_path), aliases: true)

# Use config hash to access parameters

# Define parameters from config.yml or use default values
rent_lower_bound = config.dig(Rails.env, 'rent_lower_bound') || 30000
rent_upper_bound = config.dig(Rails.env, 'rent_upper_bound') || 100000
city = config.dig(Rails.env, 'city') || ['Taipei', 'New Taipei']
districts = config.dig(Rails.env, 'districts') || ['Zqwerty', 'Pqwerty']
bedrooms_upper_bound = config.dig(Rails.env, 'bedrooms_upper_bound') || 2
mrt_line = config.dig(Rails.env, 'mrt_line') || '405 near polo ground'
net_size = config.dig(Rails.env, 'net_size') || '200sq'

# Seed Admin record
Admin.find_or_create_by(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
  admin.user_type = 'admin'
end

# Create sample properties
3.times do
  Property.create(
    rent_per_month: rand(rent_lower_bound..rent_upper_bound),
    city: city.sample,
    district: districts.sample,
    bedrooms: rand(1..bedrooms_upper_bound),
    property_type: 'residential',
    mrt_line: mrt_line,
    net_size: net_size
  )
end
