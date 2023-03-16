Rails.application.routes.draw do
  root 'main#index'
  get 'home/index'

  devise_for :users, controllers: {
    registration: 'users/registrations',
    session: 'users/session'
  }

  get '/confirm', to: "users/registrations#after_signup"

  get 'main/show', to: "main#show"
  get 'home/index', to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
