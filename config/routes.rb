Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'search'
    end
  end
  root "tasks#index"
  resources :sessions, only:[:new, :create, :destroy]
  resources :users
  namespace :admin do
    resources :users
  end
end
