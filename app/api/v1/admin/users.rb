module Api
  class V1
    class Admin
      class Users < Api::SecuredBase
        get "/" do
          check_permissions request, "admin" do |req, user_name|
            content_type :json
            User.list.to_json
          end
        end

        post "/" do
          new_user_name = params[:user_name]
          password = params[:password]

          check_permissions request, "admin" do |req, user_name|
            content_type :json
            user_id = User.add(new_user_name, password)
            {user_id: user_id}.to_json
          end
        end

        delete "/" do
          user_id = params[:user_id].to_i

          check_permissions request, "admin" do |req, user_name|
            content_type :json
            User.destroy(user_id)
            {result: true}.to_json
          end
        end
      end
    end
  end
end
