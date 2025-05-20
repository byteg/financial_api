class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :registerable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }

  has_many :balance_transactions
end
