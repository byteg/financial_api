require 'rails_helper'

RSpec.describe "Balance::Withdraw" do
  describe "#call" do
    it "withdraws the amount" do
      user = create(:user, amount_cents: 100)
      withdraw = Balance::Withdraw.new(user, 100)
      withdraw.call
      expect(user.amount_cents).to eq(0)
    end

    it "does not withdraw negative amount" do
      user = create(:user, amount_cents: 0)
      withdraw = Balance::Withdraw.new(user, -100)
      expect { withdraw.call }.to raise_error(ArgumentError, 'Amount must be greater than 0')
    end

    it "does not withdraw more than the balance" do
      user = create(:user, amount_cents: 100)
      withdraw = Balance::Withdraw.new(user, 200)
      expect { withdraw.call }.to raise_error(ArgumentError, 'Insufficient balance')
    end
  end
end
