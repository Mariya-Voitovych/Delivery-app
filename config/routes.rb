Rails.application.routes.draw do
  scope '/auth' do
    post '/signin', to: 'courier_token#create'
    post '/signup', to: 'couriers#create'
   end
  devise_for :users, path: 'user'
  get 'home/home'
  root to: 'home#home'

  devise_for :delivery_managers, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :couriers do
    resources :packages, only: %i[index new create show]
  end  
  resources :package_assignments
  resources :courier_token, only: :create
end
