class User < ActiveRecord::Base
  include BCrypt

  has_many :permissions
  has_many :scopes, through: :permissions

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

  def scopes_array
    scopes.map { |i| i.name }
  end

  class << self
    def find_by_user_name(user_name)
      User.where(user_name: user_name).first
    end

    def list
      User.all.map(&:user_name)
    end

    def add(user_name, password)
      User.create!(user_name: user_name, password: password)
    end
  end
end