require "spec_helper"

describe "Auth service" do
  context "token generation" do
    let(:jwt_issuer) { ConfigReader.get(:jwt_issuer) }
    let(:jwt_exp_minutes) { ConfigReader.get(:jwt_exp_minutes) }
    let(:jwt_secret) { ConfigReader.get(:jwt_secret) }

    it "the payload is correct" do
      user = build(:user)
      expect(Services::Auth.payload_for(user)).to eq(valid_payload)
    end
    
    it "generates a valid token" do
      user = build(:user)
      token = Services::Auth.token(user)
      payload = Services::Auth.decode(token)
      expect(payload["user"]["user_name"]).to eq(valid_payload[:user][:user_name])
      expect(payload["scopes"]).to eq(valid_payload[:scopes])
    end

    def valid_payload
      {
        exp: Time.now.to_i + jwt_exp_minutes * 60,
        iat: Time.now.to_i,
        iss: jwt_issuer,
        scopes: ["test"],
        user: {
          user_name: "user",
        },
      }
    end
  end

  context "user authenticated" do
    it "returns true if user name exists and password match" do
      password = "pass"
      user = create(:user, password: password)

      found_user = Services::Auth.user_authenticated?(user.user_name, password)

      expect(found_user).to eq(user)
    end

    it "return false if user doesn't exits" do
      found_user = Services::Auth.user_authenticated?("invented_user", "")

      expect(found_user).to eq(nil)
    end

    it "return false if user exists but password doesn't match" do
      user = create(:user)

      found_user = Services::Auth.user_authenticated?(user.user_name, "#{user.password}_wadus")

      expect(found_user).to eq(nil)
    end
  end
end
