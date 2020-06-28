Rails.application.routes.draw do
  resources :games do
    post :join, on: :member
  end

  resources :questions, only: [:index, :create]
end
