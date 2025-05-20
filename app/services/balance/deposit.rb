class Balance::Deposit
  def initialize(user, amount_cents)
    @user = user
    @amount_cents = amount_cents.to_i
  end

  def call
    User.transaction do
      @user.lock!
      raise ArgumentError, "Amount must be greater than 0" if @amount_cents <= 0
      
      @user.increment!(:amount_cents, @amount_cents)
      @user.balance_transactions.create!(amount_cents: @amount_cents)
    end
  end
end
