class JijelWeb < Sinatra::Application

  get '/sites' do
    @sites = Array.new
    Site.load_sites(session[:repo]).each do |site_path|
      @sites << Site.new(site_path)
    end
    session[:sites] = @sites
    haml :sites
	end

	get '/sites/:sitename' do |sitename|
		@sites = session[:sites]
		@sites.each do |site|
			if sitename.eql? site.name
				@site = site
				@site.load_site_data
				break
			end
		end

		if @site.nil?
			haml :sites
		else
			session[:site] = @site
			haml :site
		end
	end

end