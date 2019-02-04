require "spec_helper"

describe "Scope model" do
  describe "instance" do
    it "it's not possible to create a scope without name" do
      scope = Scope.new

      expect(scope.valid?).to be(false)
    end

    it "doesn't allow to have 2 users with the same user name" do
      create(:scope_test)

      another = build(:scope_test)

      expect(another.valid?).to be(false)
    end
  end

  describe "class" do
    context "find_by_name method" do
      it "finds a scope by name" do
        scope = double(:scope)

        expect(Scope).to receive(:where).with(name: "wadus").and_return([scope])

        expect(Scope.find_by_name("wadus")).to eq(scope)
      end

      it "returns nil if the scope doesn't exist" do
        expect(Scope).to receive(:where).with(name: "wadus").and_return([])

        expect(Scope.find_by_name("wadus")).to eq(nil)
      end
    end

    context "add_scope method" do
      it "adds a scope" do
        expect(Scope).to receive(:create!).with(name: "wadus")

        Scope.add_scope("wadus")
      end
    end

    context "find_by_id method" do
      it "finds a scope by id" do
        scope = double(:scope)
        allow(Scope).to receive(:where).with(id: 1).and_return([scope])
        expect(Scope.find_by_id(1)).to eq(scope)
      end
    end

    context "list_scopes method" do
      it "returns a list of scopes" do
        scope1 = double(:scope, id: 1, name: "scope1")
        scope2 = double(:scope, id: 2, name: "scope2")
        allow(Scope).to receive(:all).and_return([scope1, scope2])
        expect(Scope.list_scopes).to eq([{id: 1, name: "scope1"}, {id: 2, name: "scope2"}])
      end
    end

    context "delete_scope method" do
      it "should delete the scope if the scope is not used by any user" do
        expect(Scope).to receive(:destroy).with(1)
        Scope.delete_scope(1)
      end
    end
  end
end
