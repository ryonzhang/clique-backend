# config/routes.rb
Rails.application.routes.draw do
  get  'classinfos/all', to: 'classinfos#all'
  get  'classinfos/list', to: 'classinfos#list'
  get  'classinfos/tag', to: 'classinfos#find_by_tag'
  get  'classinfos/filter', to: 'classinfos#filter'
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