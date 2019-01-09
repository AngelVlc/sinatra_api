require "spec_helper"

describe "Secure API" do
  def app
    Api::V1::Secure
  end

  let(:user_name) { "wadus" }
  let(:password) { "pass" }

  context "test" do
    before(:each) do
    end

    it "should return 200 if the token is valid" do
      valid_token = AuthHelper.valid_token(user_name, ["test"])

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
      allow(Services::Auth).to receive(:payload_for).with(user_name, []).and_return(expired_payload)

      expired_token = Services::Auth.token(user_name, [])

      header "Authorization", "Bearer #{expired_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end

    it "should return 403 if the token issuer is not valid" do
      allow(Services::Auth).to receive(:payload_for).with(user_name, []).and_return(invalid_issuer_payload)

      invalid_token = Services::Auth.token(user_name, [])

      header "Authorization", "Bearer #{invalid_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end

    it "should return 403 if the token iat is not valid" do
      allow(Services::Auth).to receive(:payload_for).with(user_name, []).and_return(expired_iat_payload)

      invalid_token = Services::Auth.token(user_name, [])

      header "Authorization", "Bearer #{invalid_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end

    def payload
      Services::Auth.payload_for(user_name, [])
    end

    def expired_payload
      payload[:exp] = Time.now - 100
    end

    def invalid_issuer_payload
      payload[:iss] = "invalid_issuer"
    end

    def expired_iat_payload
      payload[:iat] = Time.now - 100
    end
  end
end
