require "json"

module Api
  class V1
    class Health < Sinatra::Base
      get "/" do
        content_type :json
        {status: true}.to_json
      end
    end
  end
end