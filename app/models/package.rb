# frozen_string_literal: true

class Package < ApplicationRecord
  STATES = %w[new processing delivered cancelled].freeze
  enum delivery_status: STATES.zip(STATES).to_h, _default: 'new', _prefix: :status
  before_create :generate_tracking_number
  attr_readonly :tracking_number

  validates_uniqueness_of :tracking_number

  private

  def generate_tracking_number
    self.tracking_number = "YA#{SecureRandom.alphanumeric(8)}AA"
  end
end
