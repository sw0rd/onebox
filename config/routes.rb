Onebox::Application.routes.draw do
  resources :pages

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => "sessions#destroy", :as => :signout
  
  root :to => "pages#index"
end
