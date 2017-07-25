# Rails Engine Documentation

This application creates an API for a series of merchants and their transactions, invoices, items, and customers.

This application uses:
  * Ruby version 2.3.3
  * Rails version 5.1.2
  * PostgreSQL version 9.6.1

In order to run Rails Engine, starting by cloning the repository:

 * From your command line run *git clone https://github.com/nickedwards109/rails_engine.git*
 * cd into the *rails_engine* folder

Then run the following commands in succession:
 * *bundle*
 * *rake db:create*
 * *rake db:migrate*
 * *rake csv:import*

Note: It takes 3-5 minutes to import the dataset so please be patient!

You can optionally run the specs by running *rspec*.

To request an API endpoint, first run *rails s*. Then, prepend 'http://localhost:3000' before the endpoint path in your browser's URL bar and send the request. Your browser will then receive data as a JSON object. The following endpoints are available:

* GET '/api/v1/customers/random'
* GET '/api/v1/customers/:id/favorite_merchant'
* GET '/api/v1/customers/:id/invoices'
* GET '/api/v1/customers/:id/transactions'
* GET '/api/v1/customers/:id'
* GET '/api/v1/customers/'
* GET '/api/v1/customers/find?parameter=x'
* GET '/api/v1/customers/find_all?parameter=x'
  * Customer parameters are id, first_name, last_name, created_at, and updated_at.

* GET '/api/v1/invoices/random'
* GET '/api/v1/invoices/:id/customer'
* GET '/api/v1/invoices/:id/invoice_items'
* GET '/api/v1/invoices/:id/items'
* GET '/api/v1/invoices/:id/merchant'
* GET '/api/v1/invoices/:id/transactions'
* GET '/api/v1/invoices/:id'
* GET '/api/v1/invoices/'
* GET '/api/v1/invoices/find?parameter=x'
* GET '/api/v1/invoices/find_all?parameter=x'
  * Invoice parameters are id, status, customer_id, merchant_id, created_at, and updated_at.

* GET '/api/v1/items/most_items?quantity=x'
* GET '/api/v1/items/most_revenue?quantity=x'
* GET '/api/v1/items/random'
* GET '/api/v1/items/:id/best_day'
* GET '/api/v1/items/:id/invoice_items'
* GET '/api/v1/items/:id/merchant'
* GET '/api/v1/items/:id'
* GET '/api/v1/items/'
* GET '/api/v1/items/find?parameter=x'
* GET '/api/v1/items/find_all?parameter=x'
  * Item parameters are id, name, description, unit_price, created_at, updated_at, and merchant_id.

* GET '/api/v1/invoice_items/random'
* GET '/api/v1/invoice_items/:id/invoice'
* GET '/api/v1/invoice_items/:id/item'
* GET '/api/v1/invoice_items/:id'
* GET '/api/v1/invoice_items/'
* GET '/api/v1/invoice_items/find?parameter=x'
* GET '/api/v1/invoice_items/find_all?parameter=x'
  * Invoice_Item parameters are id, item_id, invoice_id, quantity, unit_price, created_at, and updated_at.

* GET '/api/v1/merchants/most_items?quantity=x'
* GET '/api/v1/merchants/most_revenue?quantity=x'
* GET '/api/v1/merchants/random'
* GET '/api/v1/merchants/revenue?date=x'
* GET '/api/v1/merchants/:id/customers_with_pending_invoices'
* GET '/api/v1/merchants/:id/favorite_customer'
* GET '/api/v1/merchants/:id/invoices'
* GET '/api/v1/merchants/:id/items'
* GET '/api/v1/merchants/:id/revenue?date=x'
* GET '/api/v1/merchants/:id'
* GET '/api/v1/merchants/'
* GET '/api/v1/merchants/find?parameter=x'
* GET '/api/v1/merchants/find_all?parameter=x'
  * Merchant parameters are id, name, created_at, and updated_at.

* GET '/api/v1/transactions/random'
* GET '/api/v1/transactions/:id/invoice'
* GET '/api/v1/transactions/:id'
* GET '/api/v1/transactions/'
* GET '/api/v1/transactions/find?parameter=x'
* GET '/api/v1/transactions/find_all?parameter=x'
  * Transaction parameters are id, invoice_id, credit_card_number, credit_card_expiration_date, result, created_at, and updated_at.
