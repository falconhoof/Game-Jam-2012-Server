module Falconhoof
  module API
    class V1 < Sinatra::Base

      get '/' do
        "SUCCESS"
      end

      def self.new(*)
        super
      end

    end
  end
end
