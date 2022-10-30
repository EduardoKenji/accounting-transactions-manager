module Types
  class MutationType < Types::BaseObject
    field :create_transaction, mutation: Mutations::CreateTransaction
  end
end
