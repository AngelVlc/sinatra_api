class User < ActiveRecord::Base
  include BCrypt

  has_many :permissions
  has_many :scopes, through: :permissions, dependent: :destroy

  validates :user_name, uniqueness: { case_sensitive: false }
  validates_presence_of :user_name
  validates_presence_of :password_digest

  def password
    @bcrypt_password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @bcrypt_password = Password.create(new_password)
    self.password_digest = @bcrypt_password
  end

  def list_scopes
    scopes.map do |scope|
      {id: scope.id, name: scope.name}
    end
  end

  def scopes_array
    scopes.map { |i| i.name }
  end

  def add_scope(scope)
    self.scopes << scope
  end

  def delete_scope(scope)
    self.scopes.delete(scope)
  end

  def has_scope?(scope)
    self.scopes.include?(scope)
  end

  class << self
    def find_by_user_name(user_name)
      User.where(user_name: user_name).first
    end

    def find_by_id(id)
      User.where(id: id).first
    end

    def list_users
      User.all.map do |usr|
        {id: usr.id, user_name: usr.user_name}
      end
    end

    def add_user(user_name, password)
      User.create!(user_name: user_name, password: password)
    end

    def delete_user(id)
      User.destroy(id)
    end
  end
end