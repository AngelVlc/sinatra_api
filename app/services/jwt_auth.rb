require "jwt"

module Services
  class JwtAuth
    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        bearer = env.fetch("HTTP_AUTHORIZATION", "").slice(7..-1)
        payload, header = Services::Auth.decode(bearer)

        env[:scopes] = payload["scopes"]
        env[:user] = payload["user"]

        @app.call env
      rescue JWT::ExpiredSignature
        [403, {"Content-Type" => "text/plain"}, ["The token has expired."]]
      rescue JWT::InvalidIssuerError
        [403, {"Content-Type" => "text/plain"}, ["The token does not have a valid issuer."]]
      rescue JWT::InvalidIatError
        [403, {"Content-Type" => "text/plain"}, ['The token does not have a valid "issued at" time.']]
      rescue JWT::DecodeError
        [401, {"Content-Type" => "text/plain"}, ["A valid token must be passed."]]
      end
    end
  end
end