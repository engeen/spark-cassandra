Rails.application.routes.draw do

  resources :plogs
  resources :clients
  resources :directions
  resources :proxies
  resources :reports
  resources :analytics
  resources :cities

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users

  get 'spark', to: "dashboard#spark"
  get 'logs/:id', to: "dashboard#logs", as: :logs

  resources :authorizations, only: [:new, :create]
  resource :user_info, only: :show
  resources :plogs

  get '.well-known/:id', to: 'discovery#show'
  post 'tokens', to: proc { |env| TokenEndpoint.new.call(env) }
  get 'jwks.json', as: :jwks, to: proc { |env| [200, {'Content-Type' => 'application/json'}, [IdToken.config[:jwk_set].to_json]] }

  root to: "home#index"
end
