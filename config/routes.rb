Rails.application.routes.draw do
  root "articles#index"

  resources :users
  resources :comments
  resources :posts

end
