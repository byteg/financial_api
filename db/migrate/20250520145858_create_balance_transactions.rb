class CreateBalanceTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :balance_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :from_id
      t.integer :amount_cents, null: false
      t.timestamps
    end

    add_index :balance_transactions, :from_id
  end
end
