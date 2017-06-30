# Rails Engine Documentation

This application creates an API for a series of merchants and their transactions, invoices, items, and customers.

This application uses:
  * Ruby version 2.3.3
  * Rails version 5.1.2
  * PostgreSQL version 9.6.1

In order to run Rails Engine, starting by cloning the repository:

 * From your command line run *git clone https://github.com/nickedwards109/rails_engine.git*
 * cd into the *rails_engine* folder
 * make a ./data folder and populate it with .csv files from https://github.com/turingschool-examples/sales_engine/tree/master/data

  Then run the following commands in succession:
 * *bundle*
 * *rake db:create*
 * *rake db:migrate*
 * *rake csv:import*

Note: It takes 3-5 minutes to import the dataset so please be patient!

Finally, run the internal specs by running *rspec*, or run the external spec harness as follows:
  * run *rails s* from the root directory
  * outside of the root directory, clone the repository https://github.com/turingschool/rales_engine_spec_harness
  * navigate into rales_engine_spec_harness root directory and run *rake*


