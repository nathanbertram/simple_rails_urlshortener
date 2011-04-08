SimpleRailsUrlshortener::Application.routes.draw do
  root :to => 'short_urls#index'

  resources :short_urls
  match '/:key' => 'short_urls#redirect_url', :as => :shortened 
  
  namespace :api do
    namespace :v1 do
      resources :short_urls
    end
  end
  
end
