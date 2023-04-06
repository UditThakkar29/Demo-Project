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
  authenticate :user, lambda { |u| u.has_role? :manager } do
    mount Flipper::UI.app(Flipper) => '/flipper'
  end
  resources :projects, param: :slug do
    resources :boards, param: :slug do
      resources :sprints, param: :slug do
        resources :tickets do
          member do
            get :add_to_current_sprint
            patch :start,:test,:done
          end
        end
        member do
          get :end_sprint, :backlog_tickets, :sprint_report
          patch :select_sprint
        end
      end
    end
    resources :invitations, only: %i[new create]
    member do
      get 'remove_users'
      post 'invite_user'
    end
  end

  get 'dashboard/index', to: "dashboard#index"
end
