require "spec_helper"

describe "Auth service" do
    context "token generation" do
        let(:user_name) { "wadus" }
        let(:scopes) { ["scope"]}
        let(:jwt_issuer) { ConfigReader.get(:jwt_issuer) } 
        let(:jwt_exp_minutes) {ConfigReader.get(:jwt_exp_minutes) }
        let(:jwt_secret) { ConfigReader.get(:jwt_secret) } 
        
        it "the payload is correct" do            
            expect(Services::Auth.payload_for(user_name, scopes)).to eq(valid_payload)
        end

        it "generates a valid token" do
            token = Services::Auth.token user_name, scopes
            payload = Services::Auth.decode(token) 
            expect(payload["user"]["user_name"]).to eq(valid_payload[:user][:user_name]) 
            expect(payload["scopes"]).to eq(valid_payload[:scopes]) 
        end

        def valid_payload
            {
                exp: Time.now.to_i + jwt_exp_minutes * 60,
                iat: Time.now.to_i,
                iss: jwt_issuer,
                scopes: scopes,
                user: {
                    user_name: user_name,
                }
            }
        end
    end
end