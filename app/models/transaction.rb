class Transaction < ApplicationRecord
  validates :amount, presence: true
  validates :debit_account, presence: true, length: { maximum: 10 }
  validates :credit_account, presence: true, length: { maximum: 10 }
end
