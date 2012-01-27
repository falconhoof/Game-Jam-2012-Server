module Falconhoof
  module API
    class V1 < Sinatra::Base

      get '/?' do
        "SUCCESS"
      end

      get '/scores/?' do
        Score.top_scores.to_json
      end

      get '/scores/:user/?' do

      end

      post '/scores/?' do
        @user   = User.find_or_create(
          :username => params[:username],
          :email => params[:email])

        @score  = Score.create(:user_id => @user.id, :score => params[:score])

        @score.to_json
      end

      def self.new(*)
        super
      end

    end
  end
end
