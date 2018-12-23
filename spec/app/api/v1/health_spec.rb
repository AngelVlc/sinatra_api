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
end
