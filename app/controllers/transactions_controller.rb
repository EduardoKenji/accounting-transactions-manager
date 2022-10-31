class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /account/balance
  def balance_by_account
    @account = nil
    return unless Transaction.credit_account(params[:account]).any? || Transaction.debit_account(params[:account]).any?

    @account = params[:account]
    @balance = Transaction.credit_account(params[:account]).balance - Transaction.debit_account(params[:account]).balance
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:credit_account, :debit_account, :amount)
  end
end
