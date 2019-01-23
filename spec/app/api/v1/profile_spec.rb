require "spec_helper"
require "json"

describe "Profile API" do
  def app
    Api::V1::Profile
  end

  context "change password when the token is valid" do
    let(:user_name) { "wadus" }
    let(:password) { "pass" }

    before(:each) do
      valid_token = AuthHelper.valid_token(user_name, ["test"])

      header "Authorization", "Bearer #{valid_token}"
    end

    it "should return a 404 if the two copies of the new password don't match" do
      post "/changepassword", {old_password: "pass", new_password_1: "password1", new_password_2: "password2"}

      expect(last_response.status).to be(404)
      expect(last_response.body).to eq("New passwords don't match")
    end

    it "should return a 404 if the new password length is less than 6" do
      post "/changepassword", {old_password: "pass", new_password_1: "12345", new_password_2: "12345"}

      expect(last_response.status).to be(404)
      expect(last_response.body).to eq("New password length should have at least six chars")
    end

    it "should return a 404 if the old password is not the current user's password" do
      user = User.new(user_name: user_name, password: password)
      allow(User).to receive(:find_by_user_name).with(user.user_name).and_return(user)

      post "/changepassword", {old_password: "", new_password_1: "password", new_password_2: "password"}

      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq("Old password is not valid")
    end

    it "should return a 200 and should change the password if the old password is valid and the two copies of the new password match" do
      user = User.new(user_name: user_name, password: password)
      allow(user).to receive(:save)
      allow(User).to receive(:find_by_user_name).with(user.user_name).and_return(user)

      new_password = "new_password"

      post "/changepassword", {old_password: password, new_password_1: new_password, new_password_2: new_password}

      expect(last_response.status).to eq(200)
      expect(user.password == new_password).to be(true)
      expect(user).to have_received(:save).with(no_args)

    end
  end

  context "change password when the token is not valid" do
    it "should return a 401" do
      header "Authorization", "Bearer invalid_token"
      post "/changepassword"

      expect(last_response.status).to be(401)
    end
  end
end
