class AddValidToCouriers < ActiveRecord::Migration[6.1]
  def change
    add_column :couriers, :validation, :boolean
  end
end
