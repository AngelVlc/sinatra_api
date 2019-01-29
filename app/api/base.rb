require "sinatra/custom_logger"
require "logger"

module Api
  class Base < Sinatra::Base
    helpers Sinatra::CustomLogger

    configure :development, :production, :staging do
      logger = Logger.new(STDOUT)
      logger.level = Logger::DEBUG if development?
      set :logger, logger
      enable :logging
    end

    def return_400(message)
      halt [400, text_plain_content, [message]]
    end

    def return_401(message)
      halt [401, text_plain_content, [message]]
    end

    def return_404(message)
      halt [404, text_plain_content, [message]]
    end

    def return_403(message)
      halt [403, text_plain_content, [message]]
    end

    private
    def text_plain_content
      {"Content-Type" => "text/plain"}
    end
  end
end
