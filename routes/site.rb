class JijelWeb < Sinatra::Application

  get '/sites/:sitename' do |sitename|
    @sites = session[:sites]
    @sites.each do |site|
      if sitename.eql? site.name
        @site = site
        @site.features = Feature.load_features site
        @site.pages = Page.load_pages site
        @site.flows = Flow.load_flows site
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