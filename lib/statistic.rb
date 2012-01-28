class Statistic < Sequel::Model
  def to_json
    stats_hash = [:key => name, :val => counter].to_json
  end

  def self.to_json
    statistics = []

    Statistic.all.each do |stat|
      statistics << {
        :key => stat.name,
        :val => stat.counter }
    end

    statistics.to_json
  end
end