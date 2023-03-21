Rails.application.routes.draw do
  root 'main#index'
  get 'dashboard/index'


  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'users/sessions'
  }
  get 'confirmation_pending' => 'main#after_registration_path'

  # get '/confirm', to: "users/registrations#after_signup"

  # resources :users do
  resources :projects
  # end

  get 'main/show', to: "main#show"
  get 'dashboard/index', to: "dashboard#index"
  get 'dashboard/project', to: "dashboard#project"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
