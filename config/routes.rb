Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'wash/:type_of_vehicle' => 'washes#new'

  post 'upload/licensePlate' => 'vehicles#upload_license_plate'

  post 'wash/beginWashing/:type_of_vehicle' => 'washes#wash_vehicle'

  get 'wash/error/report/stolenVehicle' => 'washes#report_stolen_vehicle', as: 'stolen_vehicle'
end
