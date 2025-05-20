class Balance::Withdraw
    def initialize(user, amount_cents)
      @user = user
      @amount_cents = amount_cents.to_i
    end

    def call
      raise ArgumentError, "Amount must be greater than 0" if @amount_cents <= 0
      User.transaction do
        @user.lock!
        raise ArgumentError, "Insufficient balance" if @user.amount_cents < @amount_cents

        @user.decrement!(:amount_cents, @amount_cents)
        @user.balance_transactions.create!(amount_cents: @amount_cents * -1)
      end
    end
end
