require "spec_helper"

describe "User model" do
  it "it's not possible to save a user without user name" do
    user = User.new

    expect(user.valid?).to be(false)
  end

  it "it's not possible to save a user without password" do
    user = User.new(user_name: "wadus")

    expect(user.valid?).to be(false)
  end

  it "should encrypt the password" do
    new_password = "password"

    user = User.new

    expect(BCrypt::Password).to receive(:create).with(new_password)
    user.password = new_password
  end

  it "password property should return a BCrypt::Password" do
    user = User.new(password: "password")

    expect(user.password).to be_a(BCrypt::Password)
  end

  it "doesn't allow to have 2 users with the same user name" do
    user = create(:user)

    another_user = User.new(user_name: user.user_name)

    expect(another_user.valid?).to be(false)
  end

  context "find_by_user_name" do
    it "finds a user by user name" do
      user = create(:user)

      found_user = User.find_by_user_name(user.user_name)

      expect(found_user.user_name).to eq(found_user.user_name)
    end
  end

  context "scopes_array" do
    it "returns an array with the scopes of the user" do
      user = build(:user)

      scopes = user.scopes_array

      expect(scopes).to eq(["test"])
    end
  end
end
