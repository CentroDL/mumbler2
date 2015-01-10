require 'sinatra/base'
require 'redis'
require 'sinatra/reloader'
require 'json'
require 'httparty'

require_relative 'server'

run Mumbler::Server
