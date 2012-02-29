class Site

  attr_accessor :path, :name, :features, :pages, :flows

  def self.load_sites(root_dir)
    Dir.glob(root_dir + '/lib/sites/*.rb')
  end

  def initialize(site_path)
    @path = site_path
    @name = FileHelper.pretty File.basename(@path, '.rb')
  end

end