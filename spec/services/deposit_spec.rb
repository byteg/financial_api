require 'rails_helper'

RSpec.describe "Balance::Deposit" do
  describe "#call" do
    it "deposits the amount" do
      user = create(:user, amount_cents: 0)
      deposit = Balance::Deposit.new(user, 100)
      deposit.call
      expect(user.amount_cents).to eq(100)
    end

    it "does not deposit negative amount" do
      user = create(:user, amount_cents: 0)
      deposit = Balance::Deposit.new(user, -100)
      expect { deposit.call }.to raise_error(ArgumentError, "Amount must be greater than 0")
    end
  end
end
