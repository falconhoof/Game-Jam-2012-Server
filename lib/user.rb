class User < Sequel::Model
  one_to_many :scores
  one_to_many :user_statistics
end