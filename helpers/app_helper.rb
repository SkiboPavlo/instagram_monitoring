module AppHelper
  def login?
    # return false if session[:username].nil?
    username
  end

  def username
    session['username']
  end

  def get_twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = 'vQ9uqjNRxlfFSAaj4KpqLARvk'
      config.consumer_secret     = 'JLmNDtQHxbEuPaf7HzzTGlRinGzHPZk13oaXtZGhZnM1yJYdxM'
      config.access_token        = '841050097257467904-umgFcRKPZuVkpcILaar0okOAK9DcwyA'
      config.access_token_secret = 'lLkndshzcfWHfgOvIuJ2khP4kAJCZ2wjWF1oxgEoHkQfq'
    end
  end

  def log_info(data)
    puts 'LOG'
    puts '='*150
    puts data.inspect
    puts '='*150
  end

  def current_user
    User.where(username: username).first
  end
end
