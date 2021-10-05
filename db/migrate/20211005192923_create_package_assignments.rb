class CreatePackageAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :package_assignments, id: :uuid do |t|
      t.belongs_to :courier
      t.belongs_to :package

      t.timestamps
    end
  end
end
