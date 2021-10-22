FactoryBot.define do
  factory :courier do
    name { "Sergiy"}
    email { FFaker::Internet.email }
    password { 'password' }
  end
end
