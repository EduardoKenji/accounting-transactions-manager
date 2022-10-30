module Types
  # Root source for GraphQL queries
  class QueryType < Types::BaseObject
    field :transactions,
          [Types::TransactionType],
          null: false,
          description: 'Returns all transactions'

    field :transaction, TransactionType, 'Find transaction by ID' do
      argument :id, ID
    end

    field :transactions_by_credit_account, [Types::TransactionType], 'Find transactions by credit account' do
      argument :credit_account, String
    end

    field :transactions_by_debit_account, [Types::TransactionType], 'Find transactions by debit account' do
      argument :debit_account, String
    end

    def transaction(id:)
      Transaction.find(id)
    end

    def transactions_by_credit_account(credit_account:)
      Transaction.credit_account(credit_account)
    end

    def transactions_by_debit_account(debit_account:)
      Transaction.debit_account(debit_account)
    end

    def transactions
      Transaction.all
    end
  end
end
