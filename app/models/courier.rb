class Courier < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :name, presence: true
  validates :email, presence: true,uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  has_many :package_assignments
  has_many :packages, through: :package_assignments
end
