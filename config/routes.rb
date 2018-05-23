Rails.application.routes.draw do
  root to: 'conversations#index'

  devise_for :users,
    controllers: { registrations: 'users/registrations' },
    path: '/',
    path_names: {
      registration: 'sign_up',
      sign_up:      '/',
      sign_in:      'login',
      sign_out:     'logout'
    }

  get '/conversations/:id/:user_name', to: 'conversations#show', as: :me_conversation
  get '/contacts', to: 'users#index', as: :me_contacts
  get '/contacts/:id', to: 'users#show', as: :me_contact

  resource :search, only: [:show], controller: 'search'
  resources :users
  resources :conversations do
    resources :messages, shallow: true
  end

  namespace :conversation do
    get :messages_portion, to: 'messages#messages_portion'
  end

  mount ActionCable.server => '/cable'
end
