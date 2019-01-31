require "spec_helper"

describe "Admin scopes API" do
  def app
    Api::V1::Admin::Scopes
  end

  let(:user_name) { "wadus" }

  context "get '/' lists scopes" do
    it "should return a 403 if the user doesn't have permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["wadus"])

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(403)
    end

    it "should return the list if the user has permissions" do
      valid_token = AuthHelper.valid_token(user_name, ["admin"])

      list = [{id: 1, name: "scope1"}, {id: 2, name: "scope2"}]

      allow(Scope).to receive(:list_scopes).and_return(list)

      header "Authorization", "Bearer #{valid_token}"
      get "/"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(list.to_json)
    end
  end
end