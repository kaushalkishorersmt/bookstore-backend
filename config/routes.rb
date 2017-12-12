Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :authors do
        resources :books
      end
      resources :auths, only: %i[create]
    end
  end


end
