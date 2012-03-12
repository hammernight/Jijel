require 'spec_helper'
require 'models/page'
require 'models/scenario'
require 'models/site'
require 'helpers/file_helper'

describe Page do

  describe 'load_pages' do
    it 'should load the pages in the pages directory for a site' do
			#TODO break this test apart into smaller tests
      site = double('site')
      site.stub(:path => 'site_path')
      site.stub(:name => 'Site Name')
      File.should_receive(:dirname).with('site_path').and_return '.'
      page_path1 = 'page_path_1/partials/'
      page_path2 = 'page_path_2'
      Dir.should_receive(:[]).and_return [page_path1, page_path2]
      readable_file = Object.new
      File.should_receive(:open).with(page_path1, 'rb').and_return readable_file
      File.should_receive(:open).with(page_path2, 'rb').and_return readable_file
			file_contents = "page file contents\r\n\r\nelement(:element_1)\t{ browser.link(:id => 'bla') }\r\nelement(:some_element_2)\t{ browser.td(:class => 'blabla') }"
      readable_file.should_receive(:read).exactly(2).times.and_return file_contents
      File.should_receive(:basename).with(page_path1, '.rb').and_return 'page_filename_1'
      File.should_receive(:basename).with(page_path2, '.rb').and_return 'page_filename_2'
			IO.should_receive(:readlines).with(page_path1).and_return file_contents.split "\r\n"
			IO.should_receive(:readlines).with(page_path2).and_return file_contents.split "\r\n"
      pages = Page.load_pages site
      pages.size.should eq 2
      pages.each { |page|
        (page.name.eql? 'Page Filename 1 (Partial)' or page.name.eql? 'Page Filename 2').should be_true

        if page.name.eql? 'Page Filename 1 (Partial)'
          page.path.should eq page_path1
          page.filename.should eq 'page_filename_1'
          page.site.should eq site
          page.content.should eq file_contents
					page.elements.size.should eq 2
					page.elements[0][:name].should eq 'Element 1'
					#page.elements[0][:locator].should eq 'link'
					page.elements[1][:name].should eq 'Some Element 2'
					#page.elements[1][:locator].should eq 'td'
        end

        if page.name.eql? 'Page Filename 2'
          page.path.should eq page_path2
          page.filename.should eq 'page_filename_2'
          page.site.should eq site
          page.content.should eq file_contents
					page.elements.size.should eq 2
					page.elements[0][:name].should eq 'Element 1'
					#page.elements[0][:locator].should eq 'link'
					page.elements[1][:name].should eq 'Some Element 2'
					#page.elements[1][:locator].should eq 'td'
        end
      }
		end
  end
end