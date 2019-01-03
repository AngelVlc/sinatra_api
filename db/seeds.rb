require "bcrypt"
Dir.glob(File.join(".", "app", "models", "*.rb")).each { |file| require file }

require './db/seeds/users'