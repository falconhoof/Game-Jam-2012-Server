module Falconhoof
  class Web < Sinatra::Base

    get '/' do
      "SUCCESS"
    end

    def self.new(*)
      super
    end

  end
end
