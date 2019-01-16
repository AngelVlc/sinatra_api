module Api
  class SecuredBase < Api::Base
    use Services::JwtAuth

    def check_permissions(req, scope)
      scopes, user = req.env.values_at :scopes, :user_name

      if scopes.include?(scope)
        yield req, user.to_sym
      else
        return_403("Invalid permissions")
      end
    end
  end
end
