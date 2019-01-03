require "spec_helper"

describe "Permission model" do
  it "it's not possible to create a permission without user" do
    scope = create(:scope_test)
    permission = Permission.new(scope: scope)

    expect(permission.valid?).to be(false)
  end

  it "it's not possible to create a permission without scope" do
    user = User.new(user_name: "wadus")
    permission = Permission.new(user: user)

    expect(permission.valid?).to be(false)
  end

  it "doesn't allow to have 2 permissions for a single user with the same scope" do
    user = create(:user)

    permission = Permission.new(user: user, scope: user.scopes.first)

    expect(permission.valid?).to be(false)
  end
end
