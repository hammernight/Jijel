require 'spec_helper'
require 'models/feature'
require 'models/scenario'

describe Scenario do

  describe 'load_scenarios' do
    it 'should load the scenarios for a feature' do
      feature = double(Feature)
      feature_file_path = 'featurefilepath'
      feature.stub(:path => feature_file_path)
			IO.should_receive(:readlines).with(feature_file_path).and_return(["Scenario: Uno", "Scenario Outline: Dos", "BlaBla"])
      scenarios = Scenario.load_scenarios feature
      scenarios.size.should eq 2
      scenarios[0].line_number.should eq 1
      scenarios[0].feature.should eq feature
      scenarios[0].name.should eq 'Uno'
      scenarios[1].line_number.should eq 2
      scenarios[1].feature.should eq feature
      scenarios[1].name.should eq 'Dos'
    end
  end
end