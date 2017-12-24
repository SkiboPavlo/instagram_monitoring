require 'sinatra'
require 'bcrypt'
require 'twitter'
require 'byebug'
require 'mongoid'
require 'json'

Mongoid.load!('config/mongoid.yml')

require_relative 'helpers/app_helper'

Dir["#{Dir.pwd}/models/*.rb"].each { |file| require file }

class TwitterMonitoring < Sinatra::Application
  helpers do
    include AppHelper
  end

  enable :sessions

  get '/' do
    if login?
      @client = get_twitter_client
      log_info params[:twitter_name]
      @user = @client.user(params[:twitter_name])
      log_info @user
      haml :index
    else
      redirect '/login'
    end
  end

  get '/login' do
    haml :login
  end

  post '/login' do
    user = User.where(username: params[:username]).first

    if user && user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
      session['username'] = params[:username]
      # log_info session['username']
      redirect '/'
    else
      haml :error
    end
  end

  get '/signup' do
    haml :signup
  end

  post '/signup' do
    if params[:password] == params[:checkpassword]
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

      user = User.create(
        username: params[:username],
        password_hash: password_hash,
        password_salt: password_salt
      )
      log_info user.inspect
      redirect '/'
    else
      haml :error
    end
  end

  get '/logout' do
    session['username'] = nil
    redirect '/'
  end

  get '/user_search' do
    @client = get_twitter_client
    @user = @client.user(params[:twitter_name])
    log_info @user
    log_info JSON.parse(@user.to_json)
    if TwitterUser.where(name: params[:twitter_name]).first
      puts 'Such user has already been found'
    else
      db_user = TwitterUser.create(JSON.parse(@user.to_json))
      current_user.tracking_list << @user
      current_user.save
      log_info current_user
    end
    redirect '/'
  end

  get '/media_search' do
    tweets = @client.user_timeline('rubyinside', count: 20)
    log_info tweets
  end
end
