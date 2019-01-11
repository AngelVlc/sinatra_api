require "spec_helper"

describe "Auth service" do
  context "token generation" do
    let(:user_name) { "user" }
    let(:scopes) { ["test"] }
    let(:jwt_issuer) { ConfigReader.get(:jwt_issuer) }
    let(:jwt_exp_minutes) { ConfigReader.get(:jwt_exp_minutes) }
    let(:jwt_secret) { ConfigReader.get(:jwt_secret) }

    it "the payload is correct" do
      expect(Services::Auth.payload_for(user_name, scopes)).to eq(valid_payload)
    end
    
    it "generates a valid token" do
      token = Services::Auth.token(user_name, scopes)
      payload = Services::Auth.decode(token)
      puts "GENT", payload
      expect(payload["user_name"]).to eq(valid_payload[:user_name])
      expect(payload["scopes"]).to eq(valid_payload[:scopes])
    end

    def valid_payload
      {
        exp: Time.now.to_i + jwt_exp_minutes * 60,
        iat: Time.now.to_i,
        iss: jwt_issuer,
        scopes: scopes,
        user_name: user_name
      }
    end
  end

  context "user authenticated" do
    let(:password) { "pass"}
    let(:user) { User.new(user_name: "wadus", password: password) }

    it "returns true if user name exists and password match" do
      allow(User).to receive(:find_by_user_name).with(user.user_name).and_return(user)

      found_user = Services::Auth.user_authenticated?(user.user_name, password)

      expect(found_user).to eq(user)
    end

    it "return false if user doesn't exits" do
      found_user = Services::Auth.user_authenticated?("invented_user", "")

      expect(found_user).to eq(nil)
    end

    it "return false if user exists but password doesn't match" do
      allow(User).to receive(:find_by_user_name).with(user.user_name).and_return(user)

      found_user = Services::Auth.user_authenticated?(user.user_name, "wadus_wadus")

      expect(found_user).to eq(nil)
    end
  end
end
