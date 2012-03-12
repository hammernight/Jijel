class Scenario

	attr_accessor :feature, :name, :content, :line_number
	def self.load_scenarios(feature)
		scenarios = Array.new
		lines = IO.readlines feature.path
		lines.each_with_index { |line, index|
			index += 1
			if line.include? 'Scenario:' or line.include? 'Scenario Outline:'
				scenario = Scenario.new
				scenario.line_number = index
				scenario.feature = feature
				scenario.name = line.gsub /Scenario.*: /, ''
				scenarios << scenario
			end
		}
		scenarios
	end
end