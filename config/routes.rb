Rails.application.routes.draw do
  root to: 'charts#index'
  post 'refresh', to: 'charts#refresh'
  post ':id', to: 'charts#update', as: :update
end
