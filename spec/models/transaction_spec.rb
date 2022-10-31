require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'is not created without valid attributes' do
    expect(Transaction.new).to_not be_valid
  end

  it 'is not created with invalid credit_account as nil' do
    expect(Transaction.new(credit_account: nil, debit_account: 'd123456', amount: 50)).to_not be_valid
  end

  it 'is not created with invalid debit_account as nil' do
    expect(Transaction.new(credit_account: 'c123456', debit_account: nil, amount: 50)).to_not be_valid
  end

  it 'is not created with invalid amount as nil' do
    expect(Transaction.new(credit_account: 'c123456', debit_account: 'd123456', amount: nil)).to_not be_valid
  end

  it 'is not created with invalid amount as 0' do
    expect(Transaction.new(credit_account: 'c123456', debit_account: 'd123456', amount: 0)).to_not be_valid
  end

  it 'is not created with invalid amount as negative' do
    expect(Transaction.new(credit_account: 'c123456', debit_account: 'd123456', amount: -100)).to_not be_valid
  end

  it 'is not created with invalid credit_account as a lengthy (>= 16) string' do
    expect(Transaction.new(credit_account: 'c123456789123456789', debit_account: 'd123456',
                           amount: 50)).to_not be_valid
  end

  it 'is not created with invalid debit_account as a lengthy (>= 16) string' do
    expect(Transaction.new(credit_account: 'c123456', debit_account: 'd123456789123456789',
                           amount: 50)).to_not be_valid
  end

  it 'is created with valid attributes' do
    expect(Transaction.new(credit_account: 'c123456', debit_account: 'd123456', amount: 50)).to be_valid
  end
end
