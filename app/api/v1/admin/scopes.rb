module Api
  class V1
    class Admin
      class Scopes < Api::SecuredBase
        before do
          check_permissions("admin")
        end

        get "/" do
          content_type :json
          Scope.list_scopes.to_json
        end
      end
    end
  end
end
