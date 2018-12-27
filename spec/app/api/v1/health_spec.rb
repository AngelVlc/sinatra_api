require "spec_helper"
require "json"

describe "Health API" do
  def app
    Api::V1::Health
  end

  it "status should be true" do
    get "/"

    expect(JSON.parse(last_response.body)).to eq({"status" => true})
    expect(last_response.status).to eq(200)
  end

  it "users count should be 0" do
    get "/userscount"

    expect(JSON.parse(last_response.body)).to eq({"count" => 0})
    expect(last_response.status).to eq(200)
  end

  it "sentry should raise an exception" do
    expect do
      get "/sentry"
    end.to raise_exception(StandardError, "testing sentry")
  end
end
