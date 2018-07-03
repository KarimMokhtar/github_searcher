Rails.application.routes.draw do
  root 'pages#search'

  post '/search', to: 'pages#search_github'
end
