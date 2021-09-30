class AddUniqueToPackages < ActiveRecord::Migration[6.1]
  def change
    change_column :packages, :tracking_number, :string, unique: true
  end
end
