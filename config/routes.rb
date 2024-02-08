Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'properties#index' # Assuming 'pages#home' is your home page controller and action
  
  resources :properties
  resources :favorites
  delete '/remove_favorite/:property_id', to: 'favorites#destroy', as: :remove_favorite
  post '/add_favorite', to: 'favorites#create', as: :add_favorite
end
