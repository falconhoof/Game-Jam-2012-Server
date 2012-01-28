module Falconhoof
  module API
    class V1 < Sinatra::Base

      get '/?' do
        {:message => 'Up (yer maw)'}.to_json
      end

      # This does ALL THE THINGS.
      post '/report/?' do
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])
        params.delete('username')
        params.delete('email')

        @score  = Score.create(:user_id => @user.id, :score => params[:score])
        params.delete('score')

        params.each do |key, val|
          # update users stats
          @user_stat = UserStatistic.find_or_create(:user_id => @user.id, :name => key)
          @user_stat.counter = @user_stat.counter + val.to_i
          @user_stat.save

          # update global stats
          @stat = Statistic.find_or_create(:name => key)
          @stat.counter = @stat.counter + val.to_i
          @stat.save
        end

        all_the_stats = []

        @user_stats = UserStatistic.for_user @user.id
        all_the_stats << {:global => @user_stats}
        all_the_stats << {:player => Statistic.all_of_the_things}
        all_the_stats.to_json
      end

      # SCORES

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

      # STATS

      get '/stats/?' do
        @stats = Statistic.to_json
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
        @stats = Statistic.to_json
      end

      # USER

      # Find or create a new user.
      #
      # Return the user in JSON format.
      post '/users/?' do
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])

        @user.to_json
      end

      # Create a new user score
      post '/users/score/?' do
        "NOT IMPLEMENTED"
      end

      # Create new user statistics
      post '/users/stats/?' do
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])

        params.delete('username')
        params.delete('email')

        params.each do |key, val|
          @user_stat = UserStatistic.find_or_create(:user_id => @user.id, :name => key)
          @user_stat.counter = @user_stat.counter + val.to_i
          @user_stat.save
        end

        @user_stats = UserStatistic.for_user @user.id
        @user_stats.to_json
      end

      def self.new(*)
        super
      end

    end
  end
end
