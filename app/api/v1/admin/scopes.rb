module Api
  class V1
    class Admin
      class Scopes < AdminBase

        get "/" do
          content_type :json
          Scope.list_scopes.to_json
        end

        post "/" do
          name = params[:name]

          content_type :json
          scope_id = Scope.add_scope(name)
          {scope_id: scope_id}.to_json
        end

        delete "/:id" do
          scope = get_scope_by(params[:id])

          Scope.delete_scope(scope.id)

          content_type :json
          {result: true}.to_json
        end

        get "/:id/users" do
          scope = get_scope_by(params[:id])

          content_type :json
          scope.list_users.to_json
        end

        private

        def get_scope_by(id)
          scope = Scope.find_by_id(id.to_i)

          return_400("The scope doesn't exist") if scope.nil?

          scope
        end
      end
    end
  end
end
