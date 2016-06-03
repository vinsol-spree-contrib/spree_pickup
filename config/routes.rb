Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :pickup_locations
  end
  namespace :api, defaults: { format: 'json' } do
    get :search, to: 'pickup_locations#search', as: :pickup_locations_search, path: 'pickup_locations/search'
  end
end
