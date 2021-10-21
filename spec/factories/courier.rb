FactoryBot.define do
  factory :courier do
    name { "Sergiy"}
    email { FFaker::Internet.email }
  end
end
