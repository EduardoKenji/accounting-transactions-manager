class Transaction < ApplicationRecord
  validates :amount, presence: true
  validates :debit_account, presence: true, length: { maximum: 10 }
  validates :credit_account, presence: true, length: { maximum: 10 }

  scope :debit_account, ->(debit_account) { where('debit_account = ?', debit_account) }
  scope :credit_account, ->(credit_account) { where('credit_account = ?', credit_account) }
  scope :balance, -> { sum(:amount) }
end
