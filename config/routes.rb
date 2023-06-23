Rails.application.routes.draw do
  # post '/questions', to: 'questions#create'
  # patch '/questions/:id', to: 'questions#update'
  # delete '/questions/:id', to: 'questions#destroy'

  # заменяем всё на одну строчку, что то же самое
  resources :questions
end
