module Mumbler

class Server <Sinatra::Base

  enable :logging

  configure :development do
    require 'pry'
    register Sinatra::Reloader
    $db = Redis.new
  end

  configure :production do
    $db = Redis.new url: ENV["REDISTOGO_URL"]
  end

  get '/' do
    render :erb, :index
  end



end#Server

end
