class Statistic < Sequel::Model
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