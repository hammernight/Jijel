class Page

  attr_accessor :path, :name, :site, :content, :filename, :elements

  def self.load_pages(site)
    pages = Array.new
    Dir["#{File.dirname(site.path)}/../../lib/sites/#{site.name.split(' ').map {|w| w.downcase}.join('_')}/pages/**/*.rb"].each do |page_path|
      page = Page.new
      page.path = page_path
      page.filename = File.basename page_path, '.rb'
      page.name = FileHelper.pretty page.filename
      page.name << ' (Partial)' if page_path.include? '/partials/'
      page.site = site
      page.content = File.open(page_path, 'rb').read
      pages << page
    end
    pages.sort {|a,b| a.name <=> b.name}
  end

end