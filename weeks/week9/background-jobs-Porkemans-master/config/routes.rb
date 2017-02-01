Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  resources :pokemons
  post 'pokemons/report' => 'pokemons#report', as: :report

  root 'pokemons#index'
end
