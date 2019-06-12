class Vehicle < ApplicationRecord
	validates :license_plate, presence: true, uniqueness: true

	enum type_of_vehicle: [:car, :truck]

	has_many :washes
end
