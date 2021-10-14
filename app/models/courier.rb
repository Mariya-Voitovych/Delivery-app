class Courier < ApplicationRecord
  has_secure_password
   validates :name, presence: true
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
   validates :email, presence: true,uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  has_many :package_assignments
  has_many :packages, through: :package_assignments
end
