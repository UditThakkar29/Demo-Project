Rails.application.routes.draw do
  root 'main#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # devise_scope :user do
  #   get '/users', to: 'devise/registrations#new'
  #   get '/users/password', to: 'devise/passwords#new'
  # end

  get 'confirmation_pending' => 'main#after_registration_path'

  resources :projects, param: :slug do
    resources :boards, param: :slug do
      resources :sprints, param: :slug do
        resources :tickets do
          member do
            patch :start,:test,:done
          end
        end
        member do
          get :end_sprint, :backlog_tickets
          patch :select_sprint
        end
      end
    end
    resources :invitations, only: %i[new create]
    member do
      get 'remove_users'
    end
  end

  get 'dashboard/index', to: "dashboard#index"
end
