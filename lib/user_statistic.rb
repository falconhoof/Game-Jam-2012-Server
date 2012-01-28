class UserStatistic < Sequel::Model
  many_to_one :user

  def to_json

  end

  def self.for_user(user_id)
    @users_stats = UserStatistic.filter(:user_id => user_id)

    statistics = []

    @user_stats.inspect

    @users_stats.each do |stat|
      statistics << {:key => stat.name, :val => stat.counter}
    end

    statistics
  end
end