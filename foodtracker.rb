require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'sinatra/activerecord'
require 'rake'
require 'chronic'
require 'bcrypt'
require 'rack-flash'

configure(:development) { set :database, 'sqlite3:///foodtracker_db.sqlite3'}

require './models'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions => true

helpers do
	def current_user
		if session[:user_id]
			User.find(session[:user_id])
		else
			nil
		end
	end
end

get '/' do
	haml :index
end

get '/login' do
	haml :login
end

post '/login' do
	@user = User.authenticate(params['user']['email'], params['user']['password'])
	if @user
		session[:user_id] = @user.id
		flash[:notice] = "Welome back!"
		redirect "/users/#{current_user.id}"
	else
		flash[:alert] = "There was a problem with your login."
		redirect '/login'
	end
end

get '/register' do
	haml :register
end

post '/register' do
	@user = User.new(params['user'], created_at: Time.now)
	if @user.save
		session[:user_id] = @user.id
		flash[:notice] = "Welcome to FoodTracker!"
		redirect "/users/#{current_user.id}"
	else
		flash[:alert] = "Uh oh.  There was a problem with your registration."
		redirect '/register'
	end
end

get '/users/:id' do
	@user = User.find(params[:id])
	@food = @user.foods.find(:all, :order => 'created_at DESC')
	haml :activity
end

get '/log' do
	haml :log
end

post '/log' do
	if current_user
		@food = Food.new(name: params['name'], created_at: Time.now, user_id: current_user.id)
		if @food.save
			flash[:notice] = "Logged!"
		else
			flash[:alert] = "Uh oh.  Something went wrong."
		end
			redirect "/users/#{current_user.id}"
	end
end

get '/logout' do
	session[:user_id] = nil
	flash[:notice] = "You have been signed out."
	redirect '/'
end