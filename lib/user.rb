class User < Sequel::Model
  one_to_many :scores
  one_to_many :user_statistics

  def to_json
    user_hash = [:username => username, :email => email].to_json
  end
end