class WashesController < ApplicationController
	def new
		@vehicle = Vehicle.new(type_of_vehicle: Vehicle.type_of_vehicles[params[:type_of_vehicle]])
	end

	def wash_vehicle
		if stolen_vehicle?(params[:vehicle][:license_plate])
			redirect_to stolen_vehicle_path
		else
			vehicle = Vehicle.find_or_create_by(type_of_vehicle: params[:vehicle][:type_of_vehicle].to_i, license_plate: params[:vehicle][:license_plate])
			vehicle.num_of_washes += 1
			vehicle.save!

			if params[:vehicle][:type_of_vehicle].to_i == 0
				@wash = Wash.new(vehicle: vehicle, sales_price: 5.00)
				if vehicle.num_of_washes % 2 == 0
					@wash.discount = true
					@wash.discount_percentage = 0.5
					@wash.discount_value = @wash.sales_price * @wash.discount_percentage
					@wash.total_price = @wash.sales_price - @wash.discount_value
					@wash.save!
				else
					@wash.discount = false
					@wash.total_price = @wash.sales_price
					@wash.save!
				end
				render 'success'
			elsif params[:vehicle][:type_of_vehicle].to_i == 1
				@wash = Wash.new(vehicle: vehicle, sales_price: 10.00)

				@mud_in_bed_fee = params[:truck_bed_mud] == 'on' ? 2.00 : 0.00

				if vehicle.num_of_washes % 2 == 0
					@wash.discount = true
					@wash.discount_percentage = 0.5
					@wash.discount_value = @wash.sales_price * @wash.discount_percentage
					@wash.total_price = @wash.sales_price - @wash.discount_value + @mud_in_bed_fee
					@wash.save!
				else
					@wash.discount = false
					@wash.total_price = @wash.sales_price + @mud_in_bed_fee
					@wash.save!
				end
				render 'success'
			end
		end
	end

	def report_stolen_vehicle
		render 'fail'
	end

	protected

	def stolen_vehicle?(license_plate)
		if license_plate == "1111111"
			true
		else
			false
		end
	end
end
