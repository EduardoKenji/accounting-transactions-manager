FactoryBot.define do
  factory :transaction do
    credit_account { "c123456" }
    debit_account { "d123456" }
    amount { 100 }

    trait :max_amount do
      amount { (2**31-1) }
    end
  end
end