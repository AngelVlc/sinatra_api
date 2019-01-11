module Api
  class V1
    class SecuredBase < Api::V1::Base
      use Services::JwtAuth
      
      def check_permissions(req, scope)
        scopes, user = req.env.values_at :scopes, :user_name

        if scopes.include?(scope)
          yield req, user.to_sym
        else
          halt 403
        end
      end
    end
  end
end