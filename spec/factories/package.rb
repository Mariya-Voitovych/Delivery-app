FactoryBot.define do
  factory :package do
    estimated_delivery_date { '01.08.2021' }
    tracking_number { 'YA00000000AA' }
    delivery_status { 'processing' }
  end
end
