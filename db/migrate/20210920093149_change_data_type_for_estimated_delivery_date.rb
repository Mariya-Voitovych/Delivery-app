class ChangeDataTypeForEstimatedDeliveryDate < ActiveRecord::Migration[6.1]
  def change
    change_table :packages, id: :uuid do |t|
      t.change :estimated_delivery_date, :date, using: 'estimated_delivery_date::date'
    end
  end
end
