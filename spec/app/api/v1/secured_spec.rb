require "spec_helper"

describe "Secure API" do
  def app
    Api::V1::Secure
  end

  context "test" do
    it "should return 200 if the token is valid" do
      valid_token = Services::Auth.token("wadus", ["test"])

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
      payload = Services::Auth.payload_for("wadus", ["test"])

      payload[:exp] = Time.now - 100

      allow(Services::Auth).to receive(:payload_for).with("wadus", ["test"]).and_return(payload)

      expired_token = Services::Auth.token("wadus", ["test"])

      header "Authorization", "Bearer #{expired_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end
    
    it "should return 403 if the token issuer is not valid" do
      payload = Services::Auth.payload_for("wadus", ["test"])

      payload[:iss] = "invalid_issuer"

      allow(Services::Auth).to receive(:payload_for).with("wadus", ["test"]).and_return(payload)

      invalid_token = Services::Auth.token("wadus", ["test"])

      header "Authorization", "Bearer #{invalid_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end

    it "should return 403 if the token iat is not valid" do
      payload = Services::Auth.payload_for("wadus", ["test"])

      payload[:iat] = Time.now - 100

      allow(Services::Auth).to receive(:payload_for).with("wadus", ["test"]).and_return(payload)

      invalid_token = Services::Auth.token("wadus", ["test"])

      header "Authorization", "Bearer #{invalid_token}"
      get "/test"

      expect(last_response.status).to eq(403)
    end
  end
end
