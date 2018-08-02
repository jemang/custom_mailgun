Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboards#index'

  get '/logs', to: 'dashboards#event_log'
  get '/bounces', to: 'dashboards#bounces_user'
end
