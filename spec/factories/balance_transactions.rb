FactoryBot.define do
  factory :balance_transaction do
    user { nil }
    from_id { 1 }
    amount_cents { 1 }
  end
end
