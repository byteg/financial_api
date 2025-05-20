class BalanceTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :counterparty, class_name: "User", optional: true

  validates :amount_cents, presence: true
end
