# encoding: utf-8

# required gems
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'
require 'sinatra/activerecord'

# Database init
set :database, 'sqlite3:barbershop.db'

# создание сущности / add clint entity
class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
  @barbers = Barber.order 'created_at DESC'
end

get '/' do
  erb :index
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @name = params[:name]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @barber_master = params[:barber_master]
  @colorpicker = params[:colorpicker]
  @after_visit = "Спасибо #{@name}, что Вы к нам записались"

  # Validating empty input
  # HASH (with a 'new 1.9 syntax')
  hh = { name: 'Введите имя',
         phone: 'Введите номер телефона',
         date_time: 'Введите время записи' }

  @error = hh.select { |key, _value| params[key] == '' }.values.join(', ')
  return erb :visit if @error != ''
  # saving to data_base
  db = Client.new
  db.name = @name
  db.phone = @phone
  db.datestamp = @date_time
  db.barber = @barber_master
  db.color = @colorpicker
  db.save

  erb :after_visit
end
