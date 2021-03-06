require "jwt"

module Services
  class Auth
    class << self
      def payload_for(user_name, scopes)
        {
          exp: Time.now.to_i + ConfigReader.get(:jwt_exp_minutes) * 60,
          iat: Time.now.to_i,
          iss: ConfigReader.get(:jwt_issuer),
          scopes: scopes,
          user_name: user_name
        }
      end

      def token(user_name, scopes)
        JWT.encode payload_for(user_name, scopes), ConfigReader.get(:jwt_secret), "HS256"
      end

      def decode(token)
        options = {algorithm: "HS256", iss: ConfigReader.get(:jwt_issuer), verify_iss: true, verify_iat: true}
        payload, header = JWT.decode token, ConfigReader.get(:jwt_secret), true, options
        payload
      end

      def user_authenticated?(user_name, password)
        found_user = User.find_by_user_name(user_name)
        return nil if found_user.nil?
        return nil if found_user.password != password
        found_user
      end
    end
  end
end
