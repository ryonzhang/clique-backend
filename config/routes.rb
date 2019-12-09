# config/routes.rb
Rails.application.routes.draw do
  resources :friendships
  resources :userclasses
  resources :favoriteinstitutions
  resources :classcategories
  resources :institutioncategories
  resources :institutiontags
  resources :classtags
  resources :classinfos
  resources :feedbacks
  resources :tags
  resources :categories
  resources :institutions
  resources :invites
  resources :todos do
    resources :items
  end
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end