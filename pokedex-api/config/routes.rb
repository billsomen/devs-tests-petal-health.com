Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'
  namespace :api do
    namespace :v1 do
      resources :pokemons, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show, :create]
    end
  end
end
