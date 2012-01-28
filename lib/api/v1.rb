module Falconhoof
  module API
    class V1 < Sinatra::Base

      get '/?' do
        "SUCCESS"
      end

      get '/scores/?' do
        Score.top_scores
      end

      get '/scores/:user/?' do
        "Not implemented"
      end

      post '/scores/?' do
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])

        @score  = Score.create(:user_id => @user.id, :score => params[:score])

        @score.to_json
      end

      get '/stats/?' do
        @stats = Statistic.all
        @stats.to_json
      end

      get '/stats/:user/?' do
        "Not implemented"
      end

      post '/stats/?' do
        params.each do |key, val|
          @stat = Statistic.find_or_create(:name => key)
          @stat.counter = @stat.counter + val.to_i
          @stat.save
        end
        Statistic.all.inspect
      end

      def self.new(*)
        super
      end

    end
  end
end
