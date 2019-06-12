class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.integer :type_of_vehicle, null: false, default: 0
      t.string :license_plate
      t.integer :num_of_washes, default: 0

      t.timestamps
    end
  end
end
