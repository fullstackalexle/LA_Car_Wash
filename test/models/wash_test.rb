require 'test_helper'

class WashTest < ActiveSupport::TestCase
	test 'wash should not be valid without a vehicle' do
		vehicle = Wash.new
		refute vehicle.valid?
		assert_not_nil vehicle.errors[:vehicle]
	end

	test 'wash should not be valid without a sales price' do
		vehicle = Wash.new
		refute vehicle.valid?
		assert_not_nil vehicle.errors[:sales_price]
	end

	test 'wash should not be valid without a total price' do
		vehicle = Wash.new
		refute vehicle.valid?
		assert_not_nil vehicle.errors[:total_price]
	end
end
