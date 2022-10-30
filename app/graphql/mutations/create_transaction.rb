class Mutations::CreateTransaction < Mutations::BaseMutation
  argument :credit_account, String, required: true
  argument :debit_account, String, required: true
  argument :amount, Integer, required: true

  type Types::TransactionType

  def resolve(**attributes)
    Transaction.create!(attributes)
  end
end