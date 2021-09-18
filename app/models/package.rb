# frozen_string_literal: true

class Package < ApplicationRecord
  attr_readonly :tracking_number

  before_create :generate_tracking_number
  enum delivery_status: { new: 0, processing: 1, delivered: 2, cancelled: 3 }, _default: 'new', _prefix: :status

  private

  def generate_tracking_number
    self.tracking_number = "YA#{SecureRandom.alphanumeric(8)}AA"
  end
end
