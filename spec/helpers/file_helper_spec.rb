require 'spec_helper'
require 'helpers/file_helper'

describe FileHelper do

  describe 'dir_exists?' do
    it 'should return false if directory argument is nil' do
      FileHelper.dir_exists?(nil).should be_false
    end

    it 'should return false if directory argument is empty' do
      FileHelper.dir_exists?('').should be_false
    end

    it 'should return true if directory exists' do
      FileHelper.dir_exists?('.').should be_true
    end

    it 'should return false rather than raising if directory does not exist' do
      FileHelper.dir_exists?('blablabla').should be_false
    end
  end

  describe 'pretty' do
    it 'should transform file name into pretty format' do
      FileHelper.pretty('some_file_name').should eq 'Some File Name'
    end
  end

  describe 'ugly' do
    it 'should transform pretty format into a file name' do
      FileHelper.ugly('Some File Name').should eq 'some_file_name'
    end
  end

end