if User.count == 0
  user = User.create!(user_name: "user", password: "pas")
  scope_test = Scope.create!(name: "test")
  user.permissions.append(Permission.new(scope: scope_test))
  puts "User with user name '#{user.user_name}' created'"
  
  admin = User.create!(user_name: "admin", password: "pas")
  scope_admin = Scope.create!(name: "admin")
  admin.permissions.append(Permission.new(scope: scope_admin))
  puts "User with user name '#{admin.user_name}' created'"
end
