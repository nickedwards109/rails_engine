Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: "find_items_by_attribute#show"
        get '/find_all', to: "find_items_by_attribute#index"
        get '/random', to: "random_items#show"
        get ':id', to: "items#show"
        get '/', to: "items#index"
      end
      namespace :invoices do
        get '/find', to: "find_invoices_by_attribute#show"
        get '/find_all', to: "find_invoices_by_attribute#index"
        get '/random', to: "random_invoices#show"
        get ':id', to: "invoices#show"
        get '/', to: "invoices#index"
      end
      namespace :invoice_items do
        get '/find', to: "find_invoice_items_by_attribute#show"
        get '/find_all', to: "find_invoice_items_by_attribute#index"
        get '/random', to: "random_invoice_items#show"
        get ':id', to: "invoice_items#show"
        get '/', to: "invoice_items#index"
      end
      namespace :merchants do
        get ':id/items', to: "merchant_items#index"
      end
      resources :merchants, only: [:show, :index]
    end
  end
end
