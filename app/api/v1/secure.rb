module Api
  class V1
    class Secure < Sinatra::Base
      use Services::JwtAuth

      get "/test" do
        process_request request, "test" do |req, user_name|
          content_type :json
          {result: true}.to_json
        end
      end

      def process_request(req, scope)
        scopes, user = req.env.values_at :scopes, :user
        user_name = user["user_name"].to_sym

        if scopes.include?(scope)
          yield req, user_name
        else
          halt 403
        end
      end
    end
  end
end
