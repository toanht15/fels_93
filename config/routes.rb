Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout"  => "sessions#destroy"

  resources :users, except: :destroy do
    get "/:relationship" => "relationships#index", as: :relationship,
      constraints: {relationship: /(following|followers)/}
  end
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index]
  resources :words

  namespace :admin do
    resources :categories
    resources :users
    resources :words
    resources :imports
  end
end
