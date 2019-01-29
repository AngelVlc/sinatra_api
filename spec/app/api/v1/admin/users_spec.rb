require "spec_helper"

describe "Admin users API" do
  def app
    Api::V1::Admin::Users
  end

  let(:user_name) { "wadus" }

  context "get '/' lists users" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(403)
    end

    it "should return the list if the user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      list = [{id: 1, user_name: "user1"}, {id: 2, user_name: "user2"}]

      allow(User).to receive(:list_users).and_return(list)

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(list.to_json)
    end
  end

  context "post '/' adds a user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      post "/"

      expect(last_response.status).to eq(403)
    end

    it "should add it if the user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      allow(User).to receive(:add_user).with("user", "password").and_return(1)

      header "Authorization", "Bearer #{valid_token}"
      post "/", {user_name: "user", password: "password"}

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"user_id" => 1})
    end
  end

  context "delete '/' delete a user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/999"

      expect(last_response.status).to eq(403)
    end

    it "should delete it if the user has permissions" do
      user = double(:user, id: 1)

      allow(User).to receive(:find_by_id).with(1).and_return(user)
      allow(User).to receive(:delete_user).with(1)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"result" => true})
    end

    it "should return a 400 if the user doesn't exists" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The user doesn't exist")
    end
  end

  context "get '/:id/scopes' lists scopes of a user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      get "/1/scopes"

      expect(last_response.status).to eq(403)
    end

    it "should return a 400 if the user doesn't exists" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      get "/1/scopes"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The user doesn't exist")
    end

    it "should return the list if the user has permissions" do
      user = double(:user)
      scopes = [{id: 1, name: "scope1"}, {id: 2, name: "scope2"}]

      allow(User).to receive(:find_by_id).with(1).and_return(user)
      allow(user).to receive(:list_scopes).and_return(scopes)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      get "/1/scopes"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(scopes.to_json)
    end
  end

  context "post '/:id/scopes' adds a scope to the user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      post "/1/scopes", {name: "test"}

      expect(last_response.status).to eq(403)
    end

    it "should return a 400 if the user doesn't exists" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      post "/1/scopes", {name: "test"}

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The user doesn't exist")
    end

    it "should return a 400 if the scope doesn't exist" do
      user = double(:user)

      allow(User).to receive(:find_by_id).with(1).and_return(user)
      allow(Scope).to receive(:find_by_name).with("test").and_return(nil)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      post "/1/scopes", {name: "test"}

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The scope doesn't exist")
    end

    it "by using an existing one if it already exists and the user has permissions" do
      user = double(:user)

      allow(User).to receive(:find_by_id).with(1).and_return(user)

      scope = double(:scope)
      allow(Scope).to receive(:find_by_name).and_return(scope)

      expect(user).to receive(:add_scope).with(scope).and_return(99)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      post "/1/scopes", {name: "test"}

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({permission_id: 99}.to_json)
    end
  end

  context "delete '/:id_user/scopes/:id_scope' deletes a scope of the user" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1/scopes/1"

      expect(last_response.status).to eq(403)
    end

    it "should return a 400 if the user doesn't exists" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1/scopes/1"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The user doesn't exist")
    end

    it "should return a 400 if the scope doesn't exist" do
      user = double(:user)

      allow(User).to receive(:find_by_id).with(1).and_return(user)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1/scopes/1"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The scope doesn't exist")
    end

    it "should return a 400 if the user doesn't have the scope" do
      user = double(:user)
      allow(User).to receive(:find_by_id).with(1).and_return(user)

      scope = double(:scope)
      allow(Scope).to receive(:find_by_id).with(1).and_return(scope)

      allow(user).to receive(:has_scope?).with(scope).and_return(false)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1/scopes/1"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The user doesn't have the scope")
    end

    it "should delete it if the user has permissions" do
      user = double(:user)
      allow(User).to receive(:find_by_id).with(1).and_return(user)

      scope = double(:scope)
      allow(Scope).to receive(:find_by_id).with(1).and_return(scope)

      allow(user).to receive(:has_scope?).with(scope).and_return(true)

      expect(user).to receive(:delete_scope).with(scope)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/1/scopes/1"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"result" => true})
    end
  end
end
