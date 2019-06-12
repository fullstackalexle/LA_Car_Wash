require 'test_helper'

class WashesControllerTest < ActionDispatch::IntegrationTest
	test "washing vehicles with a stolen license plate of '1111111' should not create a record for a Wash resource in database and be redirect to fail page" do
		assert_no_difference('Wash.count') do
			post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111111' } }
		end

		assert_redirected_to stolen_vehicle_path
	end

	test "washing vehicles with a valid license plate should create one record for a Wash resource in database" do
		assert_difference('Wash.count') do
			post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }
		end
	end

	test "washing a car with a valid license plate should cost a sales price of $5.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.sales_price, 5.00, "Washing a car with a valid license plate should cost a sales price of $5.00")
	end

	test "washing a truck with a valid license plate should cost a sales price of $10.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' } }

		assert_equal(Wash.last.sales_price, 10.00, "Washing a truck with a valid license plate should cost a sales price of $10.00")
	end

	test "washing a truck with mud in the truck bed should include an additional $2.00 fee to every wash" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' }, truck_bed_mud: 'on' }

		assert_equal(Wash.last.total_price - Wash.last.sales_price - Wash.last.discount_value, 2.00, "Washing a truck with mud in the truck bed should include an additional $2.00 to every wash")
	end

	test "washing a vehicle on an odd numbered visit should not provide a discount" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.discount, false, "Washing a vehicle on an odd numbered visit should not provide a discount")
	end

	test "washing a vehicle on an even numbered visit should provide a discount" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.discount, true, "Washing a vehicle on an even numbered visit should provide a discount")
	end

	test "washing a vehicle on an odd numbered visit should provide a 0% discount" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.discount_percentage, 0.0, "Washing a vehicle on an even numbered visit should provide a 0% discount")
	end

	test "washing a vehicle on an even numbered visit should provide a 50% discount" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.discount_percentage, 0.5, "Washing a vehicle on an even numbered visit should provide a 50% discount")
	end

	test "washing a car with a valid license plate for an odd numbered visit should cost a total price of $5.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.total_price, 5.00, "Washing a car with a valid license plate for an odd numbered visit should cost a total price of $5.00")
	end

	test "washing a car with a valid license plate for an even numbered visit should cost a total price of $2.50" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 0, license_plate: '1111112' } }

		assert_equal(Wash.last.total_price, 2.50, "Washing a car with a valid license plate for an even numbered visit should cost a total price of $2.50")
	end

	test "washing a truck with a valid license plate and no mud in the truck bed for an odd numbered visit should cost a total price of $10.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' } }

		assert_equal(Wash.last.total_price, 10.00, "Washing a truck with a valid license plate and no mud in the truck bed for an odd numbered visit should cost a total price of $10.00")
	end

	test "washing a truck with a valid license plate and no mud in the truck bed for an even numbered visit should cost a total price of $5.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' } }
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' } }

		assert_equal(Wash.last.total_price, 5.00, "Washing a truck with a valid license plate and no mud in the truck bed for an even numbered visit should cost a total price of $5.00")
	end

	test "washing a truck with a valid license plate and with mud in the truck bed for an odd numbered visit should cost a total price of $12.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' }, truck_bed_mud: 'on' }

		assert_equal(Wash.last.total_price, 12.00, "Washing a truck with a valid license plate and with mud in the truck bed for an odd numbered visit should cost a total price of $12.00")
	end

	test "washing a truck with a valid license plate and with mud in the truck bed for an even numbered visit should cost a total price of $7.00" do
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' } }
		post '/wash/beginWashing/car', params: { vehicle: { type_of_vehicle: 1, license_plate: '1111113' }, truck_bed_mud: 'on' }

		assert_equal(Wash.last.total_price, 7.00, "Washing a truck with a valid license plate and with mud in the truck bed for an even numbered visit should cost a total price of $7.00")
	end
end
