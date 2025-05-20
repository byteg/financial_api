class UserSerializer < Blueprinter::Base
  identifier :id
  fields :email, :amount_cents
end