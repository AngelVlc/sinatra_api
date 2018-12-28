class User < ActiveRecord::Base
  include BCrypt

  validates_presence_of :user_name
  validates_presence_of :password_digest

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end