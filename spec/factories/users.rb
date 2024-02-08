FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
    trait :admin do
      user_type { 'admin' }
    end
  end
end