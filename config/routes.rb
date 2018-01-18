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

  resources :users
  resources :conversations

  root to: 'conversations#index'
end
