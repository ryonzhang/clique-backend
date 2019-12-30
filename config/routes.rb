# config/routes.rb
Rails.application.routes.draw do
  get  'sessions/all', to: 'sessions#all'
  get  'classinfos/all', to: 'classinfos#all'
  get  'classinfos/list', to: 'classinfos#list'
  get  'classinfos/tag', to: 'classinfos#find_by_tag'
  get  'classinfos/filter', to: 'classinfos#filter'
  get  'classinfos/upcoming', to: 'classinfos#upcoming'
  get  'classinfos/upcoming/:user_id', to: 'classinfos#upcoming'
  get  'classinfos/completed', to: 'classinfos#completed'
  get  'classinfos/completed/:user_id', to: 'classinfos#completed'
  get  'classinfos/new', to: 'classinfos#new'
  get  'classinfos/date/:date(.:format)', to: 'classinfos#date'
  get  'institutions/favorites', to: 'institutions#favorites'
  get  'institutions/favorites/:user_id', to: 'institutions#favorites'
  get  'institutions/:id/classes/:date', to: 'institutions#classes'
  get  'users/requested_friends', to: 'users#requested_friends'
  get  'users/friends/:user_id(.:format)', to: 'users#friends'
  get  'users/searchable/', to: 'users#searchable'
  get  'users/friends/', to: 'users#friends'
  get  'institutions/nearby/', to: 'institutions#nearby'
  get  'institutions/:id/feedbacks/', to: 'institutions#feedbacks'
  get  'classinfos/:classinfo_id/feedback', to: 'classinfos#get_feedback'
  post 'users/defriend/:id(.:format)', to: 'users#defriend'
  post 'users/invite/:id(.:format)', to: 'users#invite'
  post 'users/accept/:id(.:format)', to: 'users#accept'
  post 'users/reject/:id(.:format)', to: 'users#reject'
  post 'users/defriend/:id(.:format)', to: 'users#defriend'
  post 'users/friend/:id(.:format)', to: 'users#friend'
  post 'classinfos/link/:id(.:format)', to: 'classinfos#link'
  post 'classinfos/update/:id(.:format)', to: 'classinfos#update'
  post 'classinfos/delink/:id(.:format)', to: 'classinfos#delink'
  post 'classinfos/new/:institution_id', to: 'classinfos#create'
  post 'classinfos/:classinfo_id/feedback', to: 'classinfos#feedback'
  post 'institutions/fan/:id', to: 'institutions#fan'
  post 'institutions/defan/:id', to: 'institutions#defan'
  post 'users/update', to: 'users#update'
  post 'institutions/update/:id', to: 'institutions#update'
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

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


end