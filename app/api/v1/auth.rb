require "json"

module Api
  class V1
    class Auth < Sinatra::Base

      post "/login" do
        user_name = params[:user_name]
        password = params[:password]

        found_user = Services::Auth.user_authenticated?(user_name, password)

        if found_user
          token = Services::Auth.token(found_user.user_name, found_user.scopes_array)
          content_type :json
          {token: token}.to_json
        else
          halt 401
        end
      end
    end
  end
end
