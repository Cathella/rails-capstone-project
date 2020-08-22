Rails.application.routes.draw do
  resources :groups
  resources :transactions
  get 'users/index'
  get 'users/profile'
  get '/profile', to: 'users#profile'
  # get '/members', to: 'transactions#member_transactions'
  get '/etransactions', to: 'transactions#etransaction'

  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'edit_profile', to: 'devise/registrations#edit'
    get 'signup', to: 'devise/registrations#new'

    authenticated :user do
      root 'users#profile'
    end

    unauthenticated do
      root 'users#index'
    end
  end
end
