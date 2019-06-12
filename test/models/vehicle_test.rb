require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
	test 'vehicle should not be valid without a license plate' do
		vehicle = Vehicle.new
		refute vehicle.valid?
		assert_not_nil vehicle.errors[:license_plate]
	end
end
