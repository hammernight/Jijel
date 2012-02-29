class AutomationWeb < Sinatra::Application

  get '/sites' do
    @sites = Array.new
    Site.load_sites(session[:root_dir]).each do |site_path|
      @sites << Site.new(site_path)
    end
    session[:sites] = @sites
    haml :sites
  end

end