class Statistic < Sequel::Model
  def to_json
    stats_hash = [:key => name, :val => counter].to_json
  end

  def self.all_of_the_things
    statistics = []

    Statistic.all.each do |stat|
      statistics << {
        :key => stat.name,
        :val => stat.counter }
    end

    statistics
  end

  def self.to_json
    self.all_of_the_things.to_json
  end
end