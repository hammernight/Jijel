require 'spec_helper'
require 'models/feature'
require 'models/scenario'
require 'helpers/file_helper'

describe Feature do

  describe 'load_features' do
    it 'should load the features in the features directory for a site' do
      site = double('site')
      site.stub(:path => 'site_path')
      site.stub(:name => 'Site Name')
      File.should_receive(:dirname).with('site_path').and_return '.'
      feature_path1 = 'feature_path_1'
      feature_path2 = 'feature_path_2'
      Dir.should_receive(:[]).and_return [feature_path1, feature_path2]
      readable_file = Object.new
      File.should_receive(:open).with(feature_path1, 'rb').and_return readable_file
      File.should_receive(:open).with(feature_path2, 'rb').and_return readable_file
      scenarios = Array.new
      Scenario.should_receive(:load_scenarios).exactly(2).times.and_return scenarios
      readable_file.should_receive(:read).exactly(2).times.and_return 'feature file contents'
      File.should_receive(:basename).with(feature_path1, '.feature').and_return 'feature_filename_1'
      File.should_receive(:basename).with(feature_path2, '.feature').and_return 'feature_filename_2'

      features = Feature.load_features site
      features.size.should eq 2
      features.each { |feature|
        (feature.name.eql? 'Feature Filename 1' or feature.name.eql? 'Feature Filename 2').should be_true

        if feature.name.eql? 'Feature Filename 1'
          feature.path.should eq feature_path1
          feature.filename.should eq 'feature_filename_1'
          feature.site.should eq site
          feature.content.should eq 'feature file contents'
          feature.scenarios.should eq scenarios
        end

        if feature.name.eql? 'Feature Filename 2'
          feature.path.should eq feature_path2
          feature.filename.should eq 'feature_filename_2'
          feature.site.should eq site
          feature.content.should eq 'feature file contents'
          feature.scenarios.should eq scenarios
        end 
      }
    end
  end
end