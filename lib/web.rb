module Falconhoof
  class Web < Sinatra::Base

    get '/' do
      @title = "Coming soon!"
      erb :index
    end

    get '/high-scores/?' do
      @scores = Score.order(:score.desc).limit(20)
      @title = "High Scores"
      erb :high_scores
    end

    get '/statistics/?' do
      @stats = Statistic.all
      @title = "Statistics"
      erb :statistics
    end

    def self.new(*)
      super
    end

  end
end
