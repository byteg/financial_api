class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :registerable, :jwt_authenticatable, jwt_revocation_strategy: self
end
