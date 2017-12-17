require 'sinatra'
require 'byebug'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

get '/users' do
  @users = User.all
end

get '/users/:id' do
  @user = User.find(params[:id])
end

post '/users' do
  byebug
  @user = User.create(params[:user])
end

put '/users/:id/publish' do
  @user = user.find(params[:id])
  @user.publish!
end

delete '/users/:id' do
  user.destroy(params[:id])
end
