require 'sinatra'
require 'bcrypt'
require 'twitter'
require 'byebug'

require_relative 'helpers/app_helper'

Dir["#{Dir.pwd}/models/*.rb"].each { |file| require file }

# @client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = 'NAqZhumMd7EOgQpr6OEpgkqsw'
#   config.consumer_secret     = '1IN1qnLvwv27MQcYhBKZGbOQBVlkFwBftqBHxAgOOxbMh90Wcq'
#   config.access_token        = '841050097257467904-umgFcRKPZuVkpcILaar0okOAK9DcwyA'
#   config.access_token_secret = 'lLkndshzcfWHfgOvIuJ2khP4kAJCZ2wjWF1oxgEoHkQfq'
# end

class TwitterMonitoring < Sinatra::Application
  helpers do
    include AppHelper
  end

  enable :sessions

  get '/' do
    @client = Twitter::REST::Client.new do |config|
  config.consumer_key        = 'NAqZhumMd7EOgQpr6OEpgkqsw'
  config.consumer_secret     = '1IN1qnLvwv27MQcYhBKZGbOQBVlkFwBftqBHxAgOOxbMh90Wcq'
  config.access_token        = '841050097257467904-umgFcRKPZuVkpcILaar0okOAK9DcwyA'
  config.access_token_secret = 'lLkndshzcfWHfgOvIuJ2khP4kAJCZ2wjWF1oxgEoHkQfq'
end
tweets = @client.user_timeline('rubyinside', count: 20)
byebug
    haml :index
  end

  get '/signup' do
    haml :signup
  end

  post '/signup' do
    if params[:password] == params[:checkpassword]
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

      User.create(
        username: params[:username],
        password_hash: password_hash,
        password_salt: password_salt
      )
      redirect '/'
    else
      haml :error
    end
  end

  post '/login' do
    user = User.where(username: params[:username]).first

    if user && user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
      session[:username] = params[:username]
      redirect '/users'
    else
      haml :error
    end
  end

  get '/logout' do
    session[:username] = nil
    redirect '/'
  end

  #--- not working

  get '/user_search' do
    html = '<h1>Search for users on instagram, by name or usernames</h1>'
    for user in client.user_search('instagram')
      html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
    end
    html
  end

  get '/media_search' do
    tweets = @client.user_timeline('rubyinside', count: 20)
  end

  get '/media_popular' do
    html = '<h1>Get a list of the overall most popular media items</h1>'
    for media_item in client.media_popular
      html << "<img src='#{media_item.images.thumbnail.url}'>"
    end
    html
  end
end
