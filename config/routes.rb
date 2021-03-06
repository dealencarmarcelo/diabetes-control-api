Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      
      namespace :admin do
        resources :medicine_types
      end

      resources :users do
        resources :measurements
      end


    end
  end

end
