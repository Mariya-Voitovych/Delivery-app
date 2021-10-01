class DeliveryManager < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
