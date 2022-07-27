Rails.application.routes.draw do
  root "articles#index"

  resources :users do
    resources :comments do
      resources :posts
    end
  end

end
