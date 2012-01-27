class Score < Sequel::Model
  many_to_one :user

  def to_json
    scores_hash = [:id => id, :user => user.username, :score => score].to_json
  end

  def self.top_scores(limit = 20)
    scores = Score.order(:score.desc).limit(limit)

    high_scores = []

    scores.each do |score|
      high_scores << {
        :username => User[score.user_id].username,
        :score    => score.score }
    end

    high_scores.to_json
  end
end