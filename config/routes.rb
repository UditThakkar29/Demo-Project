Rails.application.routes.draw do
  # get 'sprints/index'
  # get 'boards/index'
  root 'main#index'
  get 'dashboard/index'


  # get '/users', to: 'devise/registrations#new'
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'users/sessions'
  }
  # devise_scope :user do
  #   get '/users', to: 'devise/registrations#new'
  #   get '/users/password', to: 'devise/passwords#new'
  # end
  get 'confirmation_pending' => 'main#after_registration_path'

  # get '/confirm', to: "users/registrations#after_signup"
  # resources :users do
  resources :projects do
    resources :boards do
      resources :sprints
    end
  end
  get '/projects/:project_id/boards/:id', to: "boards#index"
  # end

  get 'main/show', to: "main#show"
  get 'dashboard/index', to: "dashboard#index"
  get 'dashboard/project', to: "dashboard#project"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
