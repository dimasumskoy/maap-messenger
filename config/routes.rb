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

  get '/me', to: 'welcome#index', as: :user_root
  get '/me/conversations/:id/:user_name', to: 'conversations#show', as: :me_conversation
  get :messages_portion, to: 'messages#messages_portion'

  resources :users
  resources :conversations do
    resources :messages, shallow: true
  end

  root to: 'welcome#index'
end
