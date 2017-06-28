Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: "find_items_by_attribute#show"
        get '/find_all', to: "find_items_by_attribute#index"
        get '/random', to: "random_items#show"
        get ':id', to: "items#show"
        get '/', to: "items#index"
        get '/:id/merchant', to: "item_merchants#index"
        get '/:id/invoice_items', to: "invoice_items#index"
      end

      namespace :invoices do
        get '/find', to: "find_invoices_by_attribute#show"
        get '/find_all', to: "find_invoices_by_attribute#index"
        get '/random', to: "random_invoices#show"
        get ':id', to: "invoices#show"
        get '/', to: "invoices#index"
        get '/:id/customer', to: "customer#show"
        get '/:id/merchant', to: "merchant#show"
        get '/:id/items', to: "items#index"
        get '/:id/invoice_items', to: "invoice_items#index"
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

      namespace :invoice_items do
        get '/find', to: "find_invoice_items_by_attribute#show"
        get '/find_all', to: "find_invoice_items_by_attribute#index"
        get '/random', to: "random_invoice_items#show"
        get ':id', to: "invoice_items#show"
        get '/', to: "invoice_items#index"
        get '/:id/invoice', to: "invoice#show"
        get '/:id/item', to: "item#show"
      end
      namespace :merchants do
        get ':id/items', to: "merchant_items#index"
      end

      resources :merchants, only: [:show, :index]
      resources :customers, only: [:show, :index]
      resources :transactions, only: [:show, :index]
    end
  end
end
