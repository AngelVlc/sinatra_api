module Api
  class SecuredBase < Api::Base
    use Services::JwtAuth

    def check_permissions(scope)
      scopes, user = request.env.values_at :scopes, :user_name

      if scopes.include?(scope)
        @user_name = user.to_sym
      else
        return_403("Invalid permissions")
      end
    end
  end
end
