module JwtHelper
  def authenticated_user_header(user)
    user ? Devise::JWT::TestHelpers.auth_headers({}, user) : {}
  end
end
