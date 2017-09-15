# encoding: utf-8

# required gems
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

# создание сущности / add clint entity
class Client < Activerecord::Base
end

get '/' do
  "Hello World"
end
