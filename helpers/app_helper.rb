module AppHelper
  def login?
    return false if session[:username].nil?
  end

  def username
    session[:username]
  end
end
