require "spec_helper"
require "json"

describe "Auth API" do
  def app
    Api::V1::Auth
  end

  context "Login"
  it "should return a token when the user is valid" do
    get "/"
    parsed_body = JSON.parse(last_response.body)

    puts "parsed body", parsed_body

    expect(parsed_body).to have_key("token")
    expect(last_response.status).to eq(200)
  end
end
