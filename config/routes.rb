SimpleRailsUrlshortener::Application.routes.draw do
  root :to => 'short_urls#index'

  resources :short_urls
  match '/:key' => 'short_urls#redirect_url', :as => :shortened
end
