Rails.application.routes.draw do
  mount Navigator::Engine => "/navigator"

  root "home#show"
  resources :posts, only: :index
  resources :pages, only: :index
end
