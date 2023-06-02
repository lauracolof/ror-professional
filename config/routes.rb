Rails.application.routes.draw do
  resources :tweets
  resources :photos
  # /photos
  # /photos/id
  # /photos/edit


  get "/hello", to: "main#hello"
  root to: 'main#hello'

  get '/greeting', to: "main#hello"
  post '/greetings', to: "main#hello"


end
