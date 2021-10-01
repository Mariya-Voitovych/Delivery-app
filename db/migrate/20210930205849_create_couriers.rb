class CreateCouriers < ActiveRecord::Migration[6.1]
  def change
    create_table :couriers, id: :uuid do |t|
      t.string :name
      t.string :email
      
      t.timestamps
    end
  end
end
