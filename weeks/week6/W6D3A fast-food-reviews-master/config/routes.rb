Rails.application.routes.draw do
  root 'static_pages#index'

  resources :restaurants, only: [:index, :create]

  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [:index, :create, :destroy, :update]
    end
  end
end
