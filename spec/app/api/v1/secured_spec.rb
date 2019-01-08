require "spec_helper"

describe "Secure API" do
  def app
    Api::V1::Secure
  end

  let(:user_name) { "wadus" }
  let(:password) { "pass" }
  let(:user) { User.new(user_name: user_name, password: password) }

  context "test" do
    it "should return 200 if the token is valid" do
      allow(Services::Auth).to receive(:user_authenticated?).with(user_name, password).and_return(user)
      allow_any_instance_of(User).to receive(:scopes_array).with(no_args).and_return(["test"])

      valid_token = Services::Auth.token(user.user_name, user.scopes_array)

      header "Authorization", "Bearer #{valid_token}"
      get "/test"

      expect(last_response.status).to eq(200)
    end
    
    it "should return 401 if the token is not valid" do
      header "Authorization", "Bearer invalid_token"
      get "/test"
      
      expect(last_response.status).to eq(401)
    end
    
    it "should return 401 if the token has not been provided" do
      get "/test"

      expect(last_response.status).to eq(401)
    end

    it "should return 403 if the token has expired" do
      payload = Services::Auth.payload_for(user.user_name, user.scopes_array)

      payload[:exp] = Time.now - 100

      allow(Services::Auth).to receive(:payload_for).with(user.user_name, user.scopes_array).and_return(payload)

      expired_token = Services::Auth.token(user.user_name, user.scopes_array)

      header "Authorization", "Bearer #{expired_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end
    
    it "should return 403 if the token issuer is not valid" do
      payload = Services::Auth.payload_for(user.user_name, user.scopes_array)

      payload[:iss] = "invalid_issuer"

      allow(Services::Auth).to receive(:payload_for).with(user.user_name, user.scopes_array).and_return(payload)

      invalid_token = Services::Auth.token(user.user_name, user.scopes_array)

      header "Authorization", "Bearer #{invalid_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end

    it "should return 403 if the token iat is not valid" do
      payload = Services::Auth.payload_for(user.user_name, user.scopes_array)

      payload[:iat] = Time.now - 100

      allow(Services::Auth).to receive(:payload_for).with(user.user_name, user.scopes_array).and_return(payload)

      invalid_token = Services::Auth.token(user.user_name, user.scopes_array)

      header "Authorization", "Bearer #{invalid_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end
  end
end
