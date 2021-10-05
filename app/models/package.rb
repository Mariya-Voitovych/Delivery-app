# frozen_string_literal: true

class Package < ApplicationRecord
  STATES = %w[new processing delivered cancelled].freeze
  enum delivery_status: STATES.zip(STATES).to_h, _default: 'new', _prefix: :status
  has_many :package_assignments
  has_many :couriers, through: :package_assignments
  validates_uniqueness_of :tracking_number
end
