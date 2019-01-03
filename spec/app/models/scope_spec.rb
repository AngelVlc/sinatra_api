require "spec_helper"

describe "Scope model" do
  it "it's not possible to create a scope without name" do
    scope = Scope.new

    expect(scope.save).to be(false)
  end

  it "doesn't allow to have 2 users with the same user name" do
    create(:scope_test)

    another = build(:scope_test)

    expect(another.save).to be(false)
  end
end
