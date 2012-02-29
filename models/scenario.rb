class Scenario

  attr_accessor :feature, :name, :content, :line_number

  def self.load_scenarios(feature)
    scenarios = Array.new
    line_count = 0
    lines = IO.readlines feature.path
    lines.each { |line|
      line_count += 1
      if line.include? 'Scenario:' or line.include? 'Scenario Outline:'
        scenario = Scenario.new
        scenario.line_number = line_count
        scenario.feature = feature
        scenario.name = line.gsub /Scenario.*: /, ''
        scenarios << scenario
      end
    }
    scenarios
  end
end