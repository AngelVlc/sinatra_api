require "spec_helper"

describe "Admin scopes API" do
  def app
    Api::V1::Admin::Scopes
  end

  let(:user_name) { "wadus" }

  context "get '/' lists scopes" do
    it "should return a 403 if the logged user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(403)
    end

    it "should return the list if the logged user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      list = [{id: 1, name: "scope1"}, {id: 2, name: "scope2"}]

      allow(Scope).to receive(:list_scopes).and_return(list)

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(list.to_json)
    end
  end

  context "post '/' adds a scope" do
    it "should return a 403 if the logged user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      post "/"

      expect(last_response.status).to eq(403)
    end

    it "should add it if the logged user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      allow(Scope).to receive(:add_scope).with("wadus").and_return(1)

      header "Authorization", "Bearer #{valid_token}"
      post "/", {name: "wadus"}

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"scope_id" => 1})
    end
  end

  context "delete '/' deletes a scope" do
    it "should return a 403 if the logged user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      delete "/999"

      expect(last_response.status).to eq(403)
    end

    it "should delete it if the logged user has permissions" do
      scope = double(:scope, id: 1)

      allow(Scope).to receive(:find_by_id).with(1).and_return(scope)
      allow(Scope).to receive(:delete_scope).with(1)

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
      expect(last_response.body).to eq("The scope doesn't exist")
    end
  end

  context "get '/:id/users' lists users who have the scope" do
    it "should return a 403 if the logged user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      get "/1/users"

      expect(last_response.status).to eq(403)
    end

    it "should return a 400 if the scope doesn't exists" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      get "/1/users"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("The scope doesn't exist")
    end

    it "should return the list if the logged user has permissions" do
      scope = double(:scope)
      users = [{id: 1, user_name: "user1"}, {id: 2, user_name: "user2"}]

      allow(Scope).to receive(:find_by_id).with(1).and_return(scope)
      allow(scope).to receive(:list_users).and_return(users)

      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      header "Authorization", "Bearer #{valid_token}"
      get "/1/users"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(users.to_json)
    end
  end
end
