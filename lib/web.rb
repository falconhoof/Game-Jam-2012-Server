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
      @total_players = User.count
      @title = "Statistics"
      erb :statistics
    end

    get '/player-statistics/:username/?' do
      @user = User.find(:username => params[:username])
      @user_stats = UserStatistic.filter(:user_id => @user.id)
      @title = "Statistics for #{@user.username}"
      erb :user_statistics
    end

    def self.new(*)
      super
    end

  end
end
