require 'rails_helper'

RSpec.describe "BalanceTransaction", type: :model do
  it "has a valid factory" do
    expect(build(:balance_transaction)).to be_valid
  end

  it "is invalid without an amount" do
    expect(build(:balance_transaction, amount_cents: nil)).to be_invalid
  end

  it "is invalid with string amount" do
    expect(build(:balance_transaction, amount_cents: "abc")).to be_invalid
  end

  it "is invalid without a transaction type" do
    expect(build(:balance_transaction, transaction_type: nil)).to be_invalid
  end
end
