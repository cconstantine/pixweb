Rails.application.routes.draw do
  root 'renderers#show'

  resource :renderer, only: [:update, :show]
end
