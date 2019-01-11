module Api
  class V1
    class Secure < Api::V1::SecuredBase
      get "/test" do
        check_permissions request, "test" do |req, user_name|
          content_type :json
          {result: true}.to_json
        end
      end
    end
  end
end
