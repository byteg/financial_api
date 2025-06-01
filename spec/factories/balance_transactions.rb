FactoryBot.define do
  factory :balance_transaction do
    amount_cents { Faker::Number.between(from: 100, to: 1000) }
    transaction_type { :deposit }
    user { create(:user) }
  end
end
  