Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'users/registrations' },
    path: '/',
    path_names: {
      registration: 'sign_up',
      sign_up:      '/',
      sign_in:      'login',
      sign_out:     'logout'
    }

  devise_scope :user do
    authenticated :user do
      root to: 'conversations#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  get '/conversations/:id/:user_name',      to: 'conversations#show', as: :me_conversation
  get '/users/contacts/',                   to: 'users#index',        as: :me_contacts
  get '/users/:id/:user_name',              to: 'users#show',         as: :me_contact
  get '/users/:id/:user_name/profile',      to: 'users#show',         as: :me_profile
  get '/users/:id/:user_name/profile/edit', to: 'users#edit',         as: :me_edit_profile

  resource :search, only: [:show], controller: 'search'
  resources :users
  resources :conversations do
    resources :messages, shallow: true
  end

  namespace :conversation do
    get :messages_portion, to: 'messages#get_portion'
    patch :expand,         to: 'messages#expand'
  end

  root to: 'conversations#index'

  mount ActionCable.server => '/cable'
end
