class Balance::Transfer
    def initialize(current_user, amount_cents, to_user_email)
      @current_user = current_user
      @amount_cents = amount_cents.to_i
      @to_user_email = to_user_email
    end

    def call
      raise ArgumentError, "Amount must be greater than 0" if @amount_cents <= 0
      User.transaction do
        if current_user.email > to_user_email
          self.from_user = User.lock(true).find_by!(email: current_user.email)
          self.to_user = User.lock(true).find_by!(email: to_user_email)
        else
          self.to_user = User.lock(true).find_by!(email: to_user_email)
          self.from_user = User.lock(true).find_by!(email: current_user.email)
        end

        raise ArgumentError, "Insufficient balance" if from_user.amount_cents < amount_cents

        from_user.decrement!(:amount_cents, amount_cents)
        to_user.increment!(:amount_cents, amount_cents)

        from_user.balance_transactions.create!(amount_cents: amount_cents * -1, counterparty: to_user, transaction_type: :transfer)
        to_user.balance_transactions.create!(amount_cents: amount_cents, counterparty: from_user, transaction_type: :transfer)
      end

      from_user
    end

    private

    attr_accessor :current_user, :from_user, :amount_cents, :to_user_email, :to_user
end
