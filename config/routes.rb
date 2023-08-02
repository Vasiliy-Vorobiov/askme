Rails.application.routes.draw do
  root to: 'questions#index'
  # post '/questions', to: 'questions#create'
  # patch '/questions/:id', to: 'questions#update'
  # delete '/questions/:id', to: 'questions#destroy'

  # заменяем всё на одну строчку, что то же самое
  resources :questions
  resources :users, only: %i[new create]
  # Defines the root path route ("/")
  # root "articles#index"
end
