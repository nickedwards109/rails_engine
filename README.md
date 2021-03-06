# Rails Engine Documentation

Rails Engine is a public-facing API which serves business intelligence via JSON. Please feel free to reach out to the developers for examples of the API deployed to production. In order to host the API on your local machine, please keep on reading!

It's recommended that you use a browser extension such as [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc) to prettify all that sweet, sweet JSON. 

This application uses:
  * Ruby version 2.3.3
  * Rails version 5.1.2
  * PostgreSQL version 9.6.1

Once you've cloned this repository, you'll need to run the following commands in your terminal:

* rails db:setup - to create the database and prepare the tables & columns according to the schema
* rake csv:import - to import the sales data via rake task
* rails server - to launch a web server on your local machine

To request an endpoint, prepend http://localhost:3000 before the endpoint path in your browser's URL bar and send the request. Your browser will then receive data as a JSON object. 
The following endpoints are available:

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
