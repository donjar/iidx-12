Rails.application.routes.draw do
  root to: 'charts#index'
  post 'refresh', to: 'charts#refresh'
  get ':id', to: 'charts#edit', as: :edit
  post ':id', to: 'charts#update', as: :update
end
