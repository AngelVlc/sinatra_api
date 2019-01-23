require "spec_helper"

describe "Admin users API" do
  def app
    Api::V1::Admin::Users
  end

  let(:user_name) { "wadus" }

  context "list users" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(403)
    end

    it "should return the list if the user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      allow(User).to receive(:list).and_return(["user1", "user2"])

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq(["user1", "user2"])
    end
  end

  context "add user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      post "/"

      expect(last_response.status).to eq(403)
    end

    it "should add it if the user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      allow(User).to receive(:add).with("user", "password").and_return(1)

      header "Authorization", "Bearer #{valid_token}"
      post "/", {user_name: "user", password: "password"}

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"user_id" => 1})
    end
  end

  context "delete user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/"

      expect(last_response.status).to eq(403)
    end

    it "should delete it if the user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      allow(User).to receive(:destroy).with(1)

      header "Authorization", "Bearer #{valid_token}"
      delete "/", {user_id: 1}

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"result" => true})
    end
  end
end