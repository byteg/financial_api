FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    amount_cents { Faker::Number.between(from: 100, to: 1000) }
  end
end
