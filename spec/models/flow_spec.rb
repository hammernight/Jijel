require 'spec_helper'
require 'models/flow'
require 'models/scenario'
require 'helpers/file_helper'

describe Flow do

  describe 'load_flows' do
    it 'should load the flows in the flows directory for a site' do
      site = double('site')
      site.stub(:path => 'site_path')
      site.stub(:name => 'Site Name')
      File.should_receive(:dirname).with('site_path').and_return '.'
      flow_path1 = 'flow_path_1'
      flow_path2 = 'flow_path_2'
      Dir.should_receive(:[]).and_return [flow_path1, flow_path2]
      readable_file = Object.new
      File.should_receive(:open).with(flow_path1, 'rb').and_return readable_file
      File.should_receive(:open).with(flow_path2, 'rb').and_return readable_file
      readable_file.should_receive(:read).exactly(2).times.and_return 'flow file contents'
      File.should_receive(:basename).with(flow_path1, '.rb').and_return 'flow_filename_1'
      File.should_receive(:basename).with(flow_path2, '.rb').and_return 'flow_filename_2'

      flows = Flow.load_flows site
      flows.size.should eq 2
      flows.each { |flow|
        (flow.name.eql? 'Flow Filename 1' or flow.name.eql? 'Flow Filename 2').should be_true

        if flow.name.eql? 'Flow Filename 1'
          flow.path.should eq flow_path1
          flow.filename.should eq 'flow_filename_1'
          flow.site.should eq site
          flow.content.should eq 'flow file contents'
        end

        if flow.name.eql? 'Flow Filename 2'
          flow.path.should eq flow_path2
          flow.filename.should eq 'flow_filename_2'
          flow.site.should eq site
          flow.content.should eq 'flow file contents'
        end
      }
    end
  end
end