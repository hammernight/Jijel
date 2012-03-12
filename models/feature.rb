class Feature

  attr_accessor :path, :name, :site, :content, :filename, :scenarios

  def self.load_features(site)
    features = Array.new
    Dir["#{File.dirname(site.path)}/../../features/#{site.name.split(' ').map {|w| w.downcase}.join('_')}/**/*.feature"].each do |feature_path|
      feature = Feature.new
      feature.path = feature_path
      feature.filename = File.basename feature_path, '.feature'
      feature.name = FileHelper.pretty feature.filename
      feature.site = site
      feature.content = File.open(feature_path, "rb").read
      feature.scenarios = Scenario.load_scenarios feature
      features << feature
		end
    features.sort {|a,b| a.name <=> b.name}
  end

end