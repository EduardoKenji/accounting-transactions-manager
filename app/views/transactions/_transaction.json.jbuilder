json.extract! transaction, :id, :credit_account, :debit_account, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
