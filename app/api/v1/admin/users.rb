module Api
  class V1
    class Admin
      class Users < AdminBase

        get "/" do
          content_type :json
          User.list_users.to_json
        end

        post "/" do
          new_user_name = params[:user_name]
          password = params[:password]

          content_type :json
          user_id = User.add_user(new_user_name, password)
          {user_id: user_id}.to_json
        end

        delete "/:id" do
          user = get_user_by(params[:id])

          User.delete_user(user.id)

          content_type :json
          {result: true}.to_json
        end

        get "/:id/scopes" do
          user = get_user_by(params[:id])

          content_type :json
          user.list_scopes.to_json
        end

        post "/:id/scopes" do
          name = params[:name]

          user = get_user_by(params[:id])

          scope = Scope.find_by_name(name)

          return_400("The scope doesn't exist") if scope.nil?

          permission_id = user.add_scope(scope)

          content_type :json
          {permission_id: permission_id}.to_json
        end

        delete "/:id_user/scopes/:id_scope" do
          user = get_user_by(params[:id_user])
          scope = get_scope_by(params[:id_scope])

          return_400("The user doesn't have the scope") unless user.has_scope?(scope)

          user.delete_scope(scope)

          content_type :json
          {result: true}.to_json
        end

        private

        def get_user_by(id)
          user = User.find_by_id(id.to_i)

          return_400("The user doesn't exist") if user.nil?

          user
        end

        def get_scope_by(id)
          scope = Scope.find_by_id(id.to_i)

          return_400("The scope doesn't exist") if scope.nil?

          scope
        end
      end
    end
  end
end
