ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup

require 'sinatra'
require 'sinatra/sequel'
require 'sequel'
require './lib/database.rb'

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

Dir["./lib/**/*.rb"].each { |f| require f }

