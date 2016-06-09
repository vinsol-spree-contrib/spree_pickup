Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :pickup_locations
  end
  namespace :api, defaults: { format: 'json' } do
    get :search, to: 'pickup_locations#search', as: :pickup_locations_search, path: 'pickup_locations/search'
  end

  namespace :api, defaults: { format: 'json' } do
    resources :shipments, only: [:create, :update] do
      member do
        put :deliver
        put :pickup_ready
        put :pickup_ship
      end
    end
  end

end
