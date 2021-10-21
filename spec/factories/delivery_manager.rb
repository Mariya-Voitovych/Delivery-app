FactoryBot.define do
  factory :delivery_manager do
    email { FFaker::Internet.email }
    password { 'password' }
    enabled { false }
  end
end
