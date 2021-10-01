class AddCourierToPackages < ActiveRecord::Migration[6.1]
  def change
    add_reference :packages, :courier, foreign_key: true, type: :uuid
  end
end
