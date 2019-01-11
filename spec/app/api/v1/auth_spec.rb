require "spec_helper"
require "json"

describe "Auth API" do
  def app
    Api::V1::Auth
  end

  let(:user_name) { "wadus" }
  let(:password) { "pass" }
  let(:user) { User.new(user_name: user_name, password: password) }

  context "login" do
    it "should return a token when the user is valid" do
      allow(Services::Auth).to receive(:user_authenticated?).with(user_name, password).and_return(user)

      post "/login", {user_name: user_name, password: password}

      parsed_body = JSON.parse(last_response.body)

      expect(parsed_body).to have_key("token")
      expect(last_response.status).to eq(200)
    end

    it "should return a 401 when the user is not valid" do
      allow(Services::Auth).to receive(:user_authenticated?).with(user.user_name, password).and_return(nil)

      post "/login", {user_name: user_name, password: password}

      expect(last_response.status).to eq(401)
      expect(last_response.body).to eq("User or password not valid")
    end
  end
end
