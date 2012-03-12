class Site

  attr_accessor :path, :name, :features, :pages, :flows

  def self.load_sites(root_dir)
    Dir.glob(root_dir + '/lib/sites/*.rb')
	end

  def initialize(site_path)
    @path = site_path
    @name = FileHelper.pretty File.basename(@path, '.rb')
  end

	def load_site_data
		@features = Feature.load_features self
		@pages = Page.load_pages self
		@flows = Flow.load_flows self
	end

end