require 'rails_helper'

RSpec.describe "Balance::Transfer" do
  describe "#call" do
    it "transfers the amount" do
      user = create(:user, amount_cents: 100)
      other_user = create(:user, amount_cents: 0)
      transfer = Balance::Transfer.new(user, 100, other_user.email)
      transfer.call
      expect(user.reload.amount_cents).to eq(0)
      expect(other_user.reload.amount_cents).to eq(100)
    end

    it "does not transfer negative amount" do
      user = create(:user, amount_cents: 0)
      other_user = create(:user, amount_cents: 100)
      transfer = Balance::Transfer.new(user, -100, other_user.email)
      expect { transfer.call }.to raise_error(ArgumentError, "Amount must be greater than 0")
    end

    it "does not transfer more than the balance" do
      user = create(:user, amount_cents: 100)
      other_user = create(:user, amount_cents: 0)
      transfer = Balance::Transfer.new(user, 200, other_user.email)
      expect { transfer.call }.to raise_error(ArgumentError, "Insufficient balance")
    end
  end
end
