class Statistic < Sequel::Model
  many_to_one :user

  def to_json

  end

  def self.top_scores(limit = 20)

  end
end