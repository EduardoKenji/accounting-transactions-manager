module Types
  class QueryType < Types::BaseObject
    field :transactions,
          [Types::TransactionType],
          null: false,
          description: 'Returns all transactions'

    field :transaction, TransactionType, 'Find transaction by ID' do
      argument :id, ID
    end

    def transaction(id:)
      Transaction.find(id)
    end

    def transactions
      Transaction.all
    end
  end
end
