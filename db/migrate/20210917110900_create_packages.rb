# frozen_string_literal: true

class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages, id: :uuid do |t|
      t.string :estimated_delivery_date
      t.string :tracking_number, unique: true
      t.integer :delivery_status

      t.timestamps
    end
  end
end
