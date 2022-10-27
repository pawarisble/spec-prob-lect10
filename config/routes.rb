Rails.application.routes.draw do
  get 'main/login'
  post 'main/create'
  get 'main/user_Item'
  get "main/user_Item", to: "main#user_Item"
  resources :inventories
  resources :items
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
