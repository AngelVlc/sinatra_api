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
    context "find_by_name" do
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

    context "add_scope" do
      it "adds a scope" do
        expect(Scope).to receive(:create!).with(name: "wadus")

        Scope.add_scope("wadus")
      end
    end

    context "find_by_id" do
      it "finds a scope by id" do

      end
    end
  end
end
