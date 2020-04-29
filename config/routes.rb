Rails.application.routes.draw do
  root "home#index"

  ## Use devise for users, except sessions - We add 2FA here
  devise_for :users, controllers: { sessions: 'users/sessions' }

  ## Empty [] because unrequired `users` routes are not created
  ## Add 2FA endpoints
  resources :users, only: [] do
    member do
      post :enable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_enable'
      post :disable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_disable'
    end
  end

  ## Feeds endpoint
  resources :feeds, only: [:index, :destroy, :create] do
    member do
      patch :public
      patch :private
    end
  end
  
  ## Non-login users can give feedback to users on this endpoint
  get '/f/:username', as: "feedback", to: "feeds#feedback"

  ## Reports
  resources :reports, only: [:show, :create]
  get '/r/:username', as: "submit_report", to: "reports#report"

  ## Redis Endpoint for dev
  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
