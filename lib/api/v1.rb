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

        # The following is bit kludgy due to rapidly moving requirements ಠ_ಠ

        # If a usename or email is provided, create or find the user
        if (params.has_key? 'userame') || (params.has_key? 'email')
          @user = User.find_or_create(
            :username => params[:username],
            :email => params[:email])
          params.delete('username')
          params.delete('email')

          # If a score is provided, update the users' score
          if params.has_key? 'score'
            score  = Score.create(:user_id => @user.id, :score => params[:score])
            params.delete('score')
          end
        end

        key_prep = ''
        if params.has_key? 'levelId'
          key_prep = "level_#{params[:levelId]}_"
          params.delete('levelId')
        end

        params.each do |key, val|
          if @user
            # update users stats
            user_stat = UserStatistic.find_or_create(:user_id => @user.id, :name => (key_prep + key))
            user_stat.counter = user_stat.counter + val.to_i
            user_stat.save
          end

          # update global stats
          stat = Statistic.find_or_create(:name => (key_prep + key))
          stat.counter = stat.counter + val.to_i
          stat.save
        end

        # Increment game counters
        games = Statistic.find_or_create(:name => 'total_games')
        games.counter = games.counter + 1
        games.save

        if @user
          puts "We got another user"
          user_stat = UserStatistic.find_or_create(:user_id => @user.id, :name => 'total_games')
          user_stat.counter = @user_stat.counter + 1
          user_stat.save
        end

        Statistic.all_of_the_things.to_json
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
