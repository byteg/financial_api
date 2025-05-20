class Balance::Transfer
    def initialize(from_user, amount_cents, to_user_id)
      @from_user = from_user
      @amount_cents = amount_cents.to_i
      @to_user_id = to_user_id
    end
  
    def call
      raise ArgumentError, "Amount must be greater than 0" if @amount_cents <= 0
      User.transaction do
        User.where(id: [@from_user.id, @to_user_id]).lock
        raise ArgumentError, "Insufficient balance" if @from_user.amount_cents < @amount_cents

        to_user = User.find(@to_user_id)

        @from_user.decrement!(:amount_cents, @amount_cents)
        to_user.increment!(:amount_cents, @amount_cents)
        @from_user.balance_transactions.create!(amount_cents: @amount_cents * -1, counterparty: to_user)
        to_user.balance_transactions.create!(amount_cents: @amount_cents, counterparty: @from_user)
      end
    end
  end
  