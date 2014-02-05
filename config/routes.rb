Streaming::Application.routes.draw do
  root "noticias#index"
  get "/stream" => "noticias#stream"
  resources :noticias
end
