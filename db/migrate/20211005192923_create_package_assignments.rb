class CreatePackageAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :package_assignments, id: :uuid do |t|
      t.string :courier_id
      t.string :package_id

      t.timestamps
    end
  end
end
