module Api
  class V1
    class Secure < Sinatra::Base
      use Services::JwtAuth

      get "/test" do
        process_request request, "test" do |req, username|
          content_type :json
          {result: true}.to_json
        end
      end

      def process_request(req, scope)
        scopes, user = req.env.values_at :scopes, :user
        username = user["user_name"].to_sym

        if scopes.include?(scope)
          yield req, username
        else
          halt 403
        end
      end
    end
  end
end
