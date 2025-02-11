Rails.application.routes.draw do
  devise_for :users,
    path: 'users',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'sign_up'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    },
  defaults: { format: :json }

  
  get '/protected', to: 'users/protected#index'
  
  get '/health', to: 'health#show'
  
  namespace :users do
    get '/protected', to: 'protected#index'
    get '/welcome', to: 'welcome#welcome'
    root to: 'welcome#welcome'
    get '/dashboards', to: 'dashboards#index'
    
    resources :notes, only: [:index, :show, :create, :update, :destroy]
  end

end
