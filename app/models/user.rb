class User < ApplicationRecord
  devise :registerable, :validatable
end
