class AddTransactionTypeToBalanceTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :balance_transactions, :transaction_type, :integer, null: false
  end
end
