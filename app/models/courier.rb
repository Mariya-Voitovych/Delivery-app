class Courier < ApplicationRecord
  has_many :package_assignments
  has_many :packages, through: :package_assignments
end
