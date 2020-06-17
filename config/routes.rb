Rails.application.routes.draw do
  get '', to: 'games#index'
  post :create, to: 'games#create', as: :create_game
  post :join, to: 'games#join', as: :join_game
  get :show, to: 'games#show', as: :show_game
end
