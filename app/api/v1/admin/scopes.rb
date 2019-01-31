module Api
  class V1
    class Admin
      class Scopes < Api::SecuredBase
        get "/" do
          check_permissions request, "admin" do |req, user_name|
            content_type :json
            Scope.list_scopes.to_json
          end
        end
      end
    end
  end
end