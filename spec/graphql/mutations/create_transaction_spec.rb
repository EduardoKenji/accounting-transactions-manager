require 'rails_helper'

RSpec.describe Mutations::CreateTransaction, type: :request do
  describe '.resolve' do 
    it 'creates a transaction' do
      expect do
        post '/graphql', params: { query: query(credit_account: 'c123456', debit_account: 'd123456', amount: 100) }
      end.to change { Transaction.count }.by(1)
    end

    it 'returns a transaction' do
      post '/graphql', params: { query: query(credit_account: 'c123456', debit_account: 'd123456', amount: 100) }
      attributes_created_transaction = JSON.parse(response.body)['data']['createTransaction']
      expect(attributes_created_transaction).to include(
        'creditAccount' => 'c123456',
        'debitAccount' => 'd123456',
        'amount' => 100,
      )
    end
  end

  def query(credit_account:, debit_account:, amount:)
    <<~GQL
      mutation {
        createTransaction( input: {
          creditAccount: "#{credit_account}"
          debitAccount: "#{debit_account}"
          amount: #{amount} 
        }) 
        {
          id
          creditAccount
          debitAccount
          amount
          createdAt
        }
      }
    GQL
  end
end