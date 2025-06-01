class BalanceTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :counterparty, class_name: "User", optional: true

  validates :amount_cents, presence: true, numericality: true
  validates :transaction_type, presence: true

  enum :transaction_type, deposit: 0, withdraw: 1, transfer: 2
end
