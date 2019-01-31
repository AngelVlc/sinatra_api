module Api
  class V1
    class Secure < Api::SecuredBase
      before do
        check_permissions("test")
      end

      get "/test" do
        content_type :json
        {result: true}.to_json
      end
    end
  end
end
