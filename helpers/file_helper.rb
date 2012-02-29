class FileHelper

  def self.dir_exists?(dir)
    return false if (dir.nil? or dir.eql? '')
    begin
      File.new dir
      true
    rescue
      false
    end
  end

  def self.pretty text
    text.split('_').map {|w| w.capitalize }.join(' ')
  end

  def self.ugly text
    text.split(' ').map {|w| w.downcase}.join('_')
  end

end