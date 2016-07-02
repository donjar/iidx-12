Rails.application.routes.draw do
  root to: 'charts#index'
  post 'refresh', to: 'charts#refresh'
end
