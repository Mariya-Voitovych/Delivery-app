Rails.application.routes.draw do
  devise_for :users, path: 'user'
  get 'home/home'
  root to: 'home#home'

  devise_for :delivery_managers, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :couriers do
    resources :packages, only: %i[index new create show]
  end  
  resources :package_assignments
end
