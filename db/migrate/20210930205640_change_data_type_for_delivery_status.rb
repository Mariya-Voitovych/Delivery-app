class ChangeDataTypeForDeliveryStatus < ActiveRecord::Migration[6.1]
  def change
    change_table :packages, id: :uuid do |t|
      t.change :delivery_status, :string
    end
  end
end
