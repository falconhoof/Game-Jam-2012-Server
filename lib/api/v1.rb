module Falconhoof
  module API
    class V1 < Sinatra::Base

      helpers do
        # Fetch the global and players stats
        #
        # Returns a Hash with a stats in global array and a player array.
        def statistics_report(user)
            [
              {:player => (UserStatistic.for_user user.id)},
              {:global => Statistic.all_of_the_things}
            ]
        end
      end

      # Find out if the web service is up.
      #
      # Returns JSON.
      get '/?' do
        content_type :json
        {:message => 'Up (yer maw)'}.to_json
      end

      # This submits ALL THE THINGS.
      post '/report/?' do
        content_type :json
        @user = User.find_or_create(
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

        # Increment game counters
        @stat = Statistic.find_or_create(:name => 'total_games')
        @stat.counter = @stat.counter + 1
        @stat.save

        @user_stat = UserStatistic.find_or_create(:user_id => @user.id, :name => 'total_games')
        @user_stat.counter = @user_stat.counter + 1
        @user_stat.save

        statistics_report(@user).to_json
      end

      # This retrieves all the things
      get '/report/:username/?' do
        content_type :json
         @user = User.find(
            :username => params[:username])

          {:error => 'User not found'}.to_json unless @user

          statistics_report(@user).to_json
      end

      # SCORES

      get '/scores/?' do
        content_type :json
        Score.top_scores
      end

      get '/scores/:user/?' do
        content_type :json
        "Not implemented"
      end

      post '/scores/?' do
        content_type :json
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])

        @score  = Score.create(:user_id => @user.id, :score => params[:score])

        @score.to_json
      end

      # STATS

      get '/stats/?' do
        content_type :json
        @stats = Statistic.to_json
      end

      get '/stats/:user/?' do
        content_type :json
        {:error => 'Not implemented'}.to_json
      end

      post '/stats/?' do
        content_type :json
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
        content_type :json
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])

        @user.to_json
      end

      # Create a new user score
      post '/users/score/?' do
        content_type :json
        {:error => 'Not implemented'}.to_json
      end

      # Create new user statistics
      post '/users/stats/?' do
        content_type :json
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
