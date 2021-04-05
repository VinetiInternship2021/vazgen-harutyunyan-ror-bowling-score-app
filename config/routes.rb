Rails.application.routes.draw do
  root :to => "sessions#new"
  resources :frames
  resources :players
  resources :sessions
  get 'players/new/:session_id', to: 'players#new', controller: 'Players',action: 'new'
  post 'sessions/update_score',  to: 'sessions#update_score', controller: "Sessions", action: 'update_score'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
