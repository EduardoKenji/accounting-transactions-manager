# accounting-transactions-manager

Minimalist accounting software made in Ruby on Rails that exposes a GraphQL API 
* Version details
  - Ruby 3.1.2p20
  - Ruby on Rails 7.0.4
  
* Database details
  - PostgreSQL
  - The parameters `host: localhost` and `port: 5432` may be needed inside the `config/database.yml` for localhost databases.
  - The parameters `username` and `password` may also need to be changed to work accordingly with the user's PostgreSQL role.

* Queries available in GraphQL (locally accessible with the URL `http://localhost:3000/graphiql`):
   - `transactions`: fetches all transactions
   - `transaction(id: 1)`: fetches the transaction with the specified id.
   - `transactionsByCreditAccount(debitAccount: "a_credit_account")`: fetches all transactions from the specified credit account.
   - `transactionsByDebitAccount(debitAccount: "a_debit_account")`: fetches all transactions from the specified debit account.   

* Application details:
  - The user can:
    - Check all transactions(including their attributes such as `credit_account`, `debit_account`, `date` and `amount`.
    - Create a new transaction
    - Search the balance by the `debit_account`
    - Search the balance by the `credit_account`
  - Setup the application with the commands:
  ```
  bundle install
  rails db:create db:migrate
  ```
  - Run the application server on port 3000 with the command:
  ```
  rails s -p 3000 -b '0.0.0.0'
  ```
  - Run automated tests in RSpec with the command:
  ```
  rspec
  ```
  - The application's entry point(root) can be accessed locally with these URLs:
  ```
  http://localhost:3000
  http://localhost:3000/transactions/
  ```
  - The application's entry point(root) will look like this:
  
  ![image](https://user-images.githubusercontent.com/11583245/198869676-e9eb211c-f682-4d3f-9cce-16551b7d1422.png)  
