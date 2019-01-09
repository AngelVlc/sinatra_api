class AuthHelper
  class << self
    def valid_token(user_name, scopes)
      Services::Auth.token(user_name, scopes)
    end
  end
end
