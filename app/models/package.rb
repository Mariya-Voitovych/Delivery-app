# frozen_string_literal: true

class Package < ApplicationRecord
  STATES = %w[new processing delivered cancelled].freeze
  enum delivery_status: STATES.zip(STATES).to_h, _default: 'new', _prefix: :status
  belongs_to :courier
  validates_uniqueness_of :tracking_number
  attr_readonly :tracking_number
end
