require 'sinatra/base'
require 'redis'
require 'sinatra/reloader'
require 'json'
require 'httparty'

require_relative 'db_helper'
require_relative 'grav_helper'
require_relative 'server'

run Mumbler::Server
