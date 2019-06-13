class AddLicensePlateImageToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :license_plate_image, :string
  end
end
