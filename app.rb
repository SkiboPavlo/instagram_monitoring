require 'sinatra'
require 'bcrypt'
require 'instagram'
require 'byebug'

require_relative 'helpers/app_helper'

Instagram.configure do |config|
  config.client_id = '887f005c1aa24e9da51eb9f8ce1156dd'
  config.access_token = 'efc5cdcc91f043f4adb7453c3b1343db'
end

class InstagraMonitoring < Sinatra::Application
  helpers do
    include AppHelper
  end

  userTable = {}

  enable :sessions

  get '/' do
    # @recent_media = Instagram.user_recent_media(count: 25)
    haml :index
  end

  get '/signup' do
    haml :signup
  end

  post '/signup' do
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

    { username: '#{name}',
      password: 'password_hash'
   }
    params = params.map{|key, value| "#{key}=#{value}"}.join("&")
    redirect to('/users?#{params}')
  end

  post '/login' do
    if userTable.has_key?(params[:username])
      user = userTable[params[:username]]
      if user[:passwordhash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
        session[:username] = params[:username]
        redirect '/users'
      end
    end
    haml :error
  end

  get '/logout' do
    session[:username] = nil
    redirect '/'
  end

  get '/user_search' do
    html = '<h1>Search for users on instagram, by name or usernames</h1>'
    for user in client.user_search('instagram')
      html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
    end
    html
  end

  get '/media_search' do
    html = '<h1>Get a list of media close to a given latitude and longitude</h1>'
    for media_item in client.media_search('37.7808851', '-122.3948632')
      html << "<img src='#{media_item.images.thumbnail.url}'>"
    end
    html
  end

  get '/media_popular' do
    html = '<h1>Get a list of the overall most popular media items</h1>'
    for media_item in client.media_popular
      html << "<img src='#{media_item.images.thumbnail.url}'>"
    end
    html
  end
end
