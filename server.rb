module Mumbler

class Server < Sinatra::Base

  enable :logging
  helpers DatabaseHelper, GravatarHelper

  configure :development do
    require 'pry'
    register Sinatra::Reloader
    $db = Redis.new
  end

  configure :production do
    $db = Redis.new url: ENV["REDISTOGO_URL"]
  end

  get '/' do
    redirect 'mumbles'
  end

  get '/mumbles' do
    @mumbles = get_mumbles
    erb :mumbles
  end

  get '/mumbles/new' do
    erb :new
  end

  get '/mumbles/:id' do
    $db.hincrby "mumble:#{params[:id]}", "likes", 1 if params["like"] == "true"
    @mumble = get_mumble(params[:id])
    erb :mumble
  end

  post '/mumbles' do
    id = create_mumble(params)
    redirect "/mumbles/#{id}"
  end

end#Server

end
