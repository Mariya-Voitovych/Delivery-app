class CreateDeliveryManagers < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_managers, id: :uuid do |t|
      t.boolean :enabled

      t.timestamps
    end
  end
end
