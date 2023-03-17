Rails.application.routes.draw do
  root 'main#index'
  get 'home/index'


  devise_for :users, controllers: {
    registrations: 'registrations',
    session: 'users/session'
  }
  get 'confirmation_pending' => 'main#after_registration_path'

  # get '/confirm', to: "users/registrations#after_signup"

  get 'main/show', to: "main#show"
  get 'home/index', to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
