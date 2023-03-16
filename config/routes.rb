Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root 'main#index'
  get 'main/show', to: "main#show"
  get 'home/index', to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
