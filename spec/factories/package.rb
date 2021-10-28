FactoryBot.define do
  factory :package do
    estimated_delivery_date { '01.08.2021' }
    tracking_number { 'YA00000000AA' }
    delivery_status { 'processing' }
    delivery_confirmation_token_expiration { Time.now - 5*60 }
  end
end
