Rails.application.routes.draw do
  resources :tweets
  resources :photos
  # /photos_path
  # /new_photos_path
  # /edit_photo_path(:id)
  # /photo_path(:id)


  get "/hello", to: "main#hello"
  root to: 'main#hello'

  get '/greeting', to: "main#hello", as: :hi
  post '/greetings', to: "main#hello"


end
