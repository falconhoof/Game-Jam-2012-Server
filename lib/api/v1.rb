module Falconhoof
  module API
    class V1 < Sinatra::Base

      get '/?' do
        "SUCCESS"
      end

      get '/scores/?' do

      end

      get '/scores/:user' do

      end

      def self.new(*)
        super
      end

    end
  end
end
