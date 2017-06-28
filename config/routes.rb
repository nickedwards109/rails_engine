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
      
      namespace :invoices do
        get '/find', to: "find_invoice_by_attribute#show"
        get '/find_all', to: "find_invoice_by_attribute#index"
        get '/random', to: "random_invoice#show"
        get ':id', to: "invoices#show"
        get '/', to: "invoices#index"
      end

      namespace :customers do
        get "/find_all", to: "find_customers#index"
        get "/find", to: "find_customers#show"
        get "/random", to: "random_customers#show"
      end

      namespace :transactions do
        get "/find_all", to: "find_transactions#index"
        get "/find", to: "find_transactions#show"
        get "/random", to: "random_transactions#show"
      end

      namespace :merchants do
        get "/find_all", to: "find_merchants#index"
        get "/find", to: "find_merchants#show"
        get "/random", to: "random_merchants#show"
      end

      resources :merchants, only: [:show, :index]
      resources :customers, only: [:show, :index]
      resources :transactions, only: [:show, :index]
    end
  end
end
