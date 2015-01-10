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

  get '/mumbles' do

  end

  get '/mumble/new' do
  end

  get '/mumbles/:id' do
  end

end#Server

end
