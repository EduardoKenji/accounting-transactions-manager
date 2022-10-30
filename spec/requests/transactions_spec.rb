require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "GET /index" do
    context "with valid transactions" do
      let(:valid_transaction) { FactoryBot.create(:transaction, :max_amount) }
      it 'fetches all transactions' do
        get transactions_path 
        valid_transaction
        expect(assigns(:transactions).count).to eql(1)
        expect(response).to render_template(:index)
      end
    end

    context "without valid transactions" do
      it 'fetches all transactions' do
        get transactions_path 
        expect(assigns(:transactions).count).to eql(0)
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET /credit-account/search" do
    context "allow balance search by credit account" do
      it "renders the search form" do
        get credit_account_search_path
        expect(response).to render_template(:search_credit_account)
      end
    end
  end

  describe "GET /debit-account/search" do
    context "allow balance search by debit account" do
      it "renders the search form" do
        get debit_account_search_path
        expect(response).to render_template(:search_debit_account)
      end
    end
  end

  describe "GET /credit-account/balance" do
    context "shows balance for the credit account with valid transactions" do
      let(:valid_transaction) { FactoryBot.create(:transaction) }
      let(:valid_transaction_2) { FactoryBot.create(:transaction) }
      it "renders the table with the balance for the credit account" do
        valid_transaction
        valid_transaction_2
        get credit_account_balance_path, params: { credit_account: valid_transaction['credit_account'] }
        expect(response).to render_template(:balance_by_credit_account)
        expect(assigns(:balance)).to eql(valid_transaction['amount']+valid_transaction_2['amount'])
      end
    end

    context "shows balance for the credit account without transactions" do
      it "renders the table with the balance for the credit account" do
        get credit_account_balance_path, params: { credit_account: 'c123456' }
        expect(response).to render_template(:balance_by_credit_account)
        expect(assigns(:balance)).to be_nil
      end
    end
  end

  describe "GET /debit-account/balance" do
    context "shows balance for the debit account with valid transactions" do
      let(:valid_transaction) { FactoryBot.create(:transaction) }
      let(:valid_transaction_2) { FactoryBot.create(:transaction) }
      it "renders the table with the balance for the debit account" do
        valid_transaction
        valid_transaction_2
        get debit_account_balance_path, params: { debit_account: valid_transaction['debit_account']}
        expect(response).to render_template(:balance_by_debit_account)
        expect(assigns(:balance)).to eql(valid_transaction['amount']+valid_transaction_2['amount'])
      end
    end

    context "shows balance for the debit account without transactions" do
      it "renders the table with the balance for the debit account" do
        get debit_account_balance_path, params: { debit_account: 'd123456' }
        expect(response).to render_template(:balance_by_debit_account)
        expect(assigns(:balance)).to be_nil
      end
    end
  end

  describe "POST /transactions" do
    context "with valid parameters" do
      it "creates a new transaction" do
        valid_attributes = { credit_account: 'c123456', debit_account: 'd123456', amount: 100 }
        expect { post transactions_path, params: valid_attributes, as: :json }.to change(Transaction, :count).by(1)
      end
    end

    context "with invalid parameter" do
      it "will not create a new transaction due to missing amount" do
        invalid_attributes = { credit_account: 'c123456', debit_account: 'd123456' }
        expect { post transactions_path, params: invalid_attributes, as: :json }.to_not change(Transaction, :count)
      end

      it "will not create a new transaction due to missing credit_account" do
        invalid_attributes = { debit_account: 'd123456', amount: 100 }
        expect { post transactions_path, params: invalid_attributes, as: :json }.to_not change(Transaction, :count)
      end

      it "will not create a new transaction due to missing debit_account" do
        invalid_attributes = { credit_account: 'c123456', amount: 100 }
        expect { post transactions_path, params: invalid_attributes, as: :json }.to_not change(Transaction, :count)
      end

      it "will not create a new transaction due to lengthy debit_account (> 15 chars)" do
        invalid_attributes = { credit_account: 'c123456', debit_account: 'd123456789123456789', amount: 100 }
        expect { post transactions_path, params: invalid_attributes, as: :json }.to_not change(Transaction, :count)
      end

      it "will not create a new transaction due to lengthy credit_account (> 15 chars)" do
        invalid_attributes = { credit_account: 'c123456789123456789', debit_account: 'd123456', amount: 100 }
        expect { post transactions_path, params: invalid_attributes, as: :json }.to_not change(Transaction, :count)
      end
    end
  end
end
