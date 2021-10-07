class User < ApplicationRecord
  STATES = %w[courier delivery_manager].freeze
  enum role: STATES.zip(STATES).to_h, _default: 'courier'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
