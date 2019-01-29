require "spec_helper"

describe "User model" do
  describe "instance" do
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

    context "list_scopes method" do
      it "returns the scopes of the user" do
        user = User.new
        scope1 = double(:scope, id: 1, name: "scope1")
        scope2 = double(:scope, id: 2, name: "scope2")

        allow(user).to receive(:scopes).and_return([scope1, scope2])

        expect(user.list_scopes).to eq([{id: 1, name: "scope1"}, {id: 2, name: "scope2"}])
      end
    end

    context "scopes_array method" do
      it "returns an array with the scopes of the user" do
        user = build(:user)

        scopes = user.scopes_array

        expect(scopes).to eq(["test"])
      end
    end

    context "has_scope? method" do
      it "returns true if the user has a scope" do
        scope = Scope.new(name: "test")
        user = User.new

        allow(user).to receive(:scopes).and_return([scope])

        expect(user.has_scope?(scope)).to eq(true)
      end

      it "returns false if the user doesn't have a scope" do
        scope = Scope.new(name: "test")
        user = User.new

        allow(user).to receive(:scopes).and_return([])

        expect(user.has_scope?(scope)).to eq(false)
      end
    end

    context "add_scope method" do
      it "should add the scope to the user" do
        user = create(:user)
        count = user.scopes.count
        scope = Scope.new(name: "new_scope")
        user.add_scope(scope)
        expect(user.scopes.count).to eq(count + 1)
      end
    end

    context "delete_scope method" do
      it "should delete the scope to the user" do
        user = create(:user)
        count = user.scopes.count
        user.delete_scope(user.scopes.first)
        expect(user.scopes.count).to eq(count - 1)
      end
    end
  end

  describe "class" do
    context "find_by_user_name" do
      it "finds a user by user name" do
        user = double(:user)

        allow(User).to receive(:where).with(user_name: "wadus").and_return([user])

        expect(User.find_by_user_name("wadus")).to eq(user)
      end
    end

    context "find_by_id" do
      it "finds a user by id" do
        user = double(:user)

        allow(User).to receive(:find).with(1).and_return(user)

        expect(User.find(1)).to eq(user)
      end
    end

    context "list_users method" do
      it "returns an array with the users" do
        user1 = double(:user, id: 1, user_name: "user1")
        user2 = double(:user, id: 2, user_name: "user2")

        allow(User).to receive(:all).and_return([user1, user2])

        result = User.list_users

        expect(result).to eq([{id: 1, user_name: "user1"}, {id: 2, user_name: "user2"}])
      end
    end

    context "add_user method" do
      it "adds a user" do
        allow(User).to receive(:create!).with(user_name: "user", password: "password").and_return(1)

        expect(User.add_user("user", "password")).to eq(1)
      end
    end

    context "delete_user method" do
      it "deletes a user" do
        expect(User).to receive(:destroy).with(1)

        User.delete_user(1)
      end
    end
  end
end
