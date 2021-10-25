# frozen_string_literal: true

class Package < ApplicationRecord
  include AASM
  has_many :package_assignments
  has_many :couriers, through: :package_assignments
  validates_uniqueness_of :tracking_number

  aasm column: :delivery_status do
    state :new, initial: true
    state :processing
    state :delivered
    state :cancelled
    state :assigned
    state :pickuped

    event :pickup do
      transitions from: :assigned,
                  to: :pickuped
    end

    event :cancel do
      transitions from: :assigned,
                  to: :cancelled
    end
  end
end
