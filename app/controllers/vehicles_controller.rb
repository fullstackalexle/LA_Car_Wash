class VehiclesController < ApplicationController
	def upload_license_plate
		@vehicle = Vehicle.new(type_of_vehicle: params[:vehicle][:type_of_vehicle].to_i, license_plate_image: params[:vehicle][:license_plate_image])
		@vehicle.save!

		service = S3::Service.new(:access_key_id => ENV['AWS_ACCESS_KEY'],
                          		  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])

		bucket = service.buckets.find('online-resource-hub')

		new_object = bucket.objects.build("#{params[:vehicle][:license_plate_image].original_filename}")

		new_object.content = open("#{@vehicle.license_plate_image.file.file}")

		new_object.acl = :public_read

		new_object.save

		resource = OcrSpace::Resource.new(apikey: ENV['OCR_SPACE_API_KEY'])

		result = resource.convert url: new_object.url

		puts "*" * 50
		puts result
		puts "*" * 50

		render 'new'
	end
end
