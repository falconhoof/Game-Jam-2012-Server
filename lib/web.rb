module Falconhoof
  class Web < Sinatra::Base

    get '/' do
      erb :index
    end

    get '/high-scores/?' do
      @scores = Score.order(:score.desc).limit(20)
      erb :high_scores
    end

    get '/statistics/?' do
      @stats = Statistic.all
      erb :statistics
    end

    def self.new(*)
      super
    end

  end
end
