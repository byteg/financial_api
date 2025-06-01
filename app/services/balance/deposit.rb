class Balance::Deposit
  def initialize(user, amount_cents)
    @user = user
    @amount_cents = amount_cents.to_i
  end

  def call
    raise ArgumentError, "Amount must be greater than 0" if amount_cents <= 0
    User.transaction do
      user.increment!(:amount_cents, amount_cents)
      user.balance_transactions.create!(amount_cents: amount_cents, transaction_type: :deposit)
    end
  end

  private 

  attr_reader :user, :amount_cents
end
