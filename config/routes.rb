Onebox::Application.routes.draw do
  resources :pages
  resources :auctions
  
  match '/search/:query' => "pages#search", :as => :search
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => "sessions#destroy", :as => :signout
  
  root :to => "pages#index"
end
