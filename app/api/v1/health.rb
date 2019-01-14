require "json"

module Api
  class V1
    class Health < Sinatra::Base
      get "/" do
        content_type :json
        {status: true, env: ENV["RACK_ENV"]}.to_json
      end

      get "/userscount" do
        content_type :json
        {count: User.count}.to_json
      end

      get "/sentry" do
        raise StandardError, "testing sentry"
      end
    end
  end
end
