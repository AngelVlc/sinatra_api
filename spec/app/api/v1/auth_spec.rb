require "spec_helper"
require "json"

describe "Auth API" do
  def app
    Api::V1::Auth
  end

  context "login" do
    let(:user_name) { "wadus" }
    let(:password) { "pass" }

    it "should return a token when the user is valid" do
      allow(Services::Auth).to receive(:user_is_valid).with(user_name, password).and_return(true)
      
      post "/login", { user_name: user_name, password: password }
      
      parsed_body = JSON.parse(last_response.body)

      expect(parsed_body).to have_key("token")
      expect(last_response.status).to eq(200)
    end

    it "should return a 401 when the user is not valid" do
      allow(Services::Auth).to receive(:user_is_valid).with(user_name, password).and_return(false)
      
      post "/login", { user_name: user_name, password: password }

      expect(last_response.status).to eq(401)
    end
  end
end
