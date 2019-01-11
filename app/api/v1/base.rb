require 'sinatra/custom_logger'
require 'logger'

module Api
  class V1
    class Base < Sinatra::Base
      helpers Sinatra::CustomLogger

      configure :development, :production do
        logger = Logger.new(STDOUT)
        logger.level = Logger::DEBUG if development?
        set :logger, logger
        enable :logging
      end

      def return_401(message)
        halt [401, {"Content-Type" => "text/plain"}, [message]]
      end

      def return_404(message)
        halt [404, {"Content-Type" => "text/plain"}, [message]]
      end
    end
  end
end
