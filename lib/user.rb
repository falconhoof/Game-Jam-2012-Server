class User < Sequel::Model
  one_to_many :scores, :user_statistics
end