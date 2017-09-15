# encoding: utf-8

# required gems
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'
require 'sinatra/activerecord'

# Database init
set :database, "sqlite3:barbershop.db"

# создание сущности / add clint entity
class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

get '/' do
  "Hello World"
end
