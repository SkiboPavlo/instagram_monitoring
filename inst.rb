require 'sinatra'
require 'instagram'

Instagram.configure do |config|
  config.client_id = '887f005c1aa24e9da51eb9f8ce1156dd'
  config.access_token = 'efc5cdcc91f043f4adb7453c3b1343db'
end

get '/' do
  @recent_media = Instagram.user_recent_media(count: 25)
  erb :index
end

get "/user_search" do
  html = "<h1>Search for users on instagram, by name or usernames</h1>"
  for user in client.user_search("instagram")
    html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
  end
  html
end

get "/media_search" do
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Get a list of media close to a given latitude and longitude</h1>"
  for media_item in client.media_search("37.7808851","-122.3948632")
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  html
end

get "/media_popular" do
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Get a list of the overall most popular media items</h1>"
  for media_item in client.media_popular
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  html
end
