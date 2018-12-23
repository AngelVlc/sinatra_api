require "json"

module Api
  class V1
    class Auth < Sinatra::Base

      post "/login" do
        user_name = params[:user_name]
        password = params[:password]

        if Services::Auth.user_is_valid(user_name, password)
          token = Services::Auth.token(user_name, [])
          content_type :json
          {token: token}.to_json
        else
          halt 401
        end
      end
    end
  end
end
