Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: "find_item_by_attribute#show"
        get '/find_all', to: "find_item_by_attribute#index"
        get '/random', to: "random_item#show"
        get ':id', to: "items#show"
        get '/', to: "items#index"
      end
      namespace :customers do
        get "/find_all", to: "find_customers#index"
        get "/find", to: "find_customers#show"
      end

      resources :merchants, only: [:show, :index]
      resources :customers, only: [:show, :index]
    end
  end
end
