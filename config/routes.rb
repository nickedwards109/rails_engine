Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get "/find", to: "find_customers#show"
        get "/find_all", to: "find_customers#index"
        get "/random", to: "random_customers#show"
        get "/:id/favorite_merchant", to: "favorite_merchant#show"
        get "/:id/invoices", to: "customer_invoices#index"
        get "/:id/transactions", to: "customer_transactions#index"
        get "/:id", to: "customers#show"
        get "/", to: "customers#index"
      end

      namespace :invoices do
        get '/find', to: "find_invoices_by_attribute#show"
        get '/find_all', to: "find_invoices_by_attribute#index"
        get '/random', to: "random_invoices#show"
        get '/:id/customer', to: "customer#show"
        get '/:id/items', to: "items#index"
        get '/:id/invoice_items', to: "invoice_items#index"
        get '/:id/merchant', to: "merchant#show"
        get '/:id/transactions', to: "transactions#index"
        get '/:id', to: "invoices#show"
        get '/', to: "invoices#index"
      end

      namespace :items do
        get '/find', to: "find_items_by_attribute#show"
        get '/find_all', to: "find_items_by_attribute#index"
        get '/most_items', to: "most_items#index"
        get '/most_revenue', to: "most_revenue#index"
        get '/random', to: "random_items#show"
        get '/:id/best_day', to: "best_day#index"
        get '/:id/invoice_items', to: "invoice_items#index"
        get '/:id/merchant', to: "item_merchants#index"
        get '/:id', to: "items#show"
        get '/', to: "items#index"
      end

      namespace :invoice_items do
        get '/find', to: "find_invoice_items_by_attribute#show"
        get '/find_all', to: "find_invoice_items_by_attribute#index"
        get '/random', to: "random_invoice_items#show"
        get '/:id/invoice', to: "invoice#show"
        get '/:id/item', to: "item#show"
        get '/:id', to: "invoice_items#show"
        get '/', to: "invoice_items#index"
      end

      namespace :merchants do
        get "/find", to: "find_merchants#show"
        get "/find_all", to: "find_merchants#index"
        get "/random", to: "random_merchants#show"
        get "/revenue", to: "merchant_revenues#index"
        get "/most_items", to: "top_merchants_by_items_sold#index"
        get "/most_revenue", to: "top_merchants_by_revenue#index"
        get "/:id/customers_with_pending_invoices", to: "unpaid_invoices#index"
        get "/:id/favorite_customer", to: "merchant_favorite_customers#show"
        get "/:id/invoices", to: "merchant_invoices#index"
        get "/:id/items", to: "merchant_items#index"
        get "/:id/revenue", to: "merchant_revenues#show"
        get "/:id", to: "merchants#show"
        get "/", to: "merchants#index"
      end

      namespace :transactions do
        get "/find", to: "find_transactions#show"
        get "/find_all", to: "find_transactions#index"
        get "/random", to: "random_transactions#show"
        get "/:id/invoice", to: "transaction_invoices#show"
        get "/:id", to: "transactions#show"
        get "/", to: "transactions#index"
      end
    end
  end
end
