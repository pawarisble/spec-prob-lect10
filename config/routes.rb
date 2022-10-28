Rails.application.routes.draw do
  get 'main/login'
  post 'main/create'
  get 'main/user_Item'
  get "main/user_Item", to: "main#user_Item"
  post "main/user_item_del", to: "main#user_item_del"
  get 'shop/:id', to: "main#shop_show_index"
  get "main/inventories", to: "main#show_inventory"
  post 'main/buy_item', to: 'main#buy_item'
  resources :inventories
  resources :items
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
