Rails.application.routes.draw do
  root 'pattern#index'

  resources :pattern

  resource :device, only: :update
end
