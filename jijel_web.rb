require 'rubygems'
require 'sinatra'
require 'haml'
require 'git'

class JijelWeb < Sinatra::Application
	enable :sessions
	set :haml, :format => :html5
	set :environment, :development

	before do
		redirect '/repo' unless has_repo?
	end

	get '/' do
		redirect '/sites'
	end

	get '/repo' do
		haml :root
	end

	post '/repo' do
		dir = params[:repo]
		begin
			FileUtils.rm_rf 'tmp'
			git = Git.clone dir, "tmp/#{dir.split('/').last}"
			raise if git.nil?
			session[:repo] = "tmp/#{dir.split('/').last}"
			redirect '/'
		rescue Exception => e
			puts e
			@dne = true
			haml :root
		end

		#if FileHelper.dir_exists? dir
		#	session[:root_dir] = dir
		#	redirect '/sites'
		#else
		#	@dne = true
		#	haml :root
		#end
	end

	get '/settings' do
		haml :settings
	end

	post '/search' do
		search_text = params[:search_text]
		puts search_text
		haml :search_results
	end

	def has_repo?
		session[:repo] or request.url.include? 'repo'
	end

end