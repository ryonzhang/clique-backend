# config/routes.rb
Rails.application.routes.draw do
  get  'classinfos/all', to: 'classinfos#all'
  get  'classinfos/list', to: 'classinfos#list'
  get  'classinfos/tag', to: 'classinfos#find_by_tag'
  get  'classinfos/filter', to: 'classinfos#filter'
  get  'classinfos/upcoming', to: 'classinfos#upcoming'
  get  'classinfos/completed', to: 'classinfos#completed'
  get  'classinfos/new', to: 'classinfos#new'
  post 'classinfos/link/:id(.:format)', to: 'classinfos#link'
  post 'classinfos/delink/:id(.:format)', to: 'classinfos#delink'
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