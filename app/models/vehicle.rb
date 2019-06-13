class Vehicle < ApplicationRecord
	# validates :license_plate, uniqueness: true

	enum type_of_vehicle: [:car, :truck]

	has_many :washes

	mount_uploader :license_plate_image, LicensePlateImageUploader
end
