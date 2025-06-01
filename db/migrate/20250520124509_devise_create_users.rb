# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false
      t.integer :amount_cents, default: 0
      t.string :jti, null: false
      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
    add_index :users, :jti, unique: true
    add_check_constraint :users, "amount_cents >= 0", name: "amount_cents_check"
  end
end
