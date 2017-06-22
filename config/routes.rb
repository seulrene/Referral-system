Rails.application.routes.draw do
  devise_for :users
  root 'refer#index'
  post '/refer', to: 'refer#create'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
