require 'sinatra'
require 'haml'

class JijelWeb < Sinatra::Application
	enable :sessions
	set :haml, :format => :html5
	set :environment, :development

	before do
		redirect '/root_dir' unless (session[:root_dir] or request.url.include? 'root_dir')
	end

	get '/' do
		redirect '/sites'
	end

	get '/root_dir' do
		@root_dir = session[:root_dir]
		haml :root
	end

	post '/root_dir' do
		dir = params[:root_dir]
		if FileHelper.dir_exists? dir
			session[:root_dir] = dir
			session[:dne] = nil
			redirect '/sites'
		else
			session[:dne] = true
			redirect '/root_dir'
		end
	end

end