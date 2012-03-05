class Page

	attr_accessor :path, :name, :site, :content, :filename, :elements

	def self.load_pages(site)
		pages = Array.new
		find_pages(site).each do |page_path|
			pages << build_page(site, page_path)
		end
		sort_pages pages
	end

	private

	def self.sort_pages(pages)
		pages.sort { |a, b| a.name <=> b.name }
	end

	def self.find_pages(site)
		Dir["#{File.dirname(site.path)}/../../lib/sites/#{site.name.split(' ').map { |w| w.downcase }.join('_')}/pages/**/*.rb"]
	end

	def self.build_page(site, page_path)
		page = Page.new
		page.path = page_path
		page_name! page, page_path
		page.site = site
		page.content = page_content page_path
		page.elements = page_elements page_path
		page
	end

	def self.page_name!(page, page_path)
		page.filename = File.basename page_path, '.rb'
		page.name = FileHelper.pretty page.filename
		page.name << ' (Partial)' if partial?(page_path)
	end

	def self.partial?(page_path)
		page_path.include? '/partials/'
	end

	def self.page_content(page_path)
		File.open(page_path, 'rb').read
	end

	def self.page_elements(page_path)
		elements = Array.new
		lines = IO.readlines page_path
		lines.each { |line|
			if line.include? 'element(:'
				element_name = FileHelper.pretty(line.scan(/&*\w*\)/)[0]).gsub(')', '')
				locator = ''
				elements << {
						:name => element_name,
						:locator => locator
				}
			end
		}
		elements
	end

end