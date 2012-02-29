require 'spec_helper'
require 'models/site'
require 'helpers/file_helper'

describe Site do

	describe 'load_sites' do
		it 'should create an array of all site files' do
			root_dir = 'some directory'
			glob = %w(bla bla)
			Dir.should_receive(:glob).with("#{root_dir}/lib/sites/*.rb").and_return glob
			Site.load_sites(root_dir).should eq glob
		end
	end

	describe 'initialize' do
		it 'should create a Site with a path and name' do
			site_path = 'some path'
			filename = 'some_file_name'
			File.should_receive(:basename).with(site_path, '.rb').and_return filename
			site_name = 'Site Name'
			FileHelper.should_receive(:pretty).with(filename).and_return site_name
			site = Site.new site_path
			site.path.should eq site_path
			site.name.should eq site_name
		end
	end
end