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

# создание сущности с валидацией / add clint entity with validation
class Client < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :barber, presence: true
  validates :color, presence: true
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
  @db = Client.new
  erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do
  @after_visit = "Спасибо #{@name}, что Вы к нам записались"

  # saving to data_base by the cool way
  @db = Client.new params[:client]

  if @db.save
    erb :after_visit
  else
    @error = @db.errors.full_messages.first
    erb :visit
  end
end

get '/barber/:id' do
  @barber = Barber.find(params[:id])
  erb :barber
end

get '/bookings' do
  @clients = Client.order 'created_at DESC'
  erb :bookings
end

get '/client/:id' do
  @client = Client.find(params[:id])
  erb :clients
end

post '/contacts' do
  @usrname = params[:usrname]
  @email = params[:email]
  @message = params[:message]
  @after_contacts = "Спасибо #{@name}, что за Ваше обращение"

  # Validating empty input
  # HASH (with a 'new 1.9 syntax')
  hh = { usrname: 'Введите имя',
         email: 'Введите Ваш email',
         message: 'Напишите что-нибудь' }

  @error = hh.select { |key, _value| params[key] == '' }.values.join(', ')
  return erb :visit if @error != ''
  # saving to data_base
  db = Contact.new
  db.usrname = @usrname
  db.email = @email
  db.message = @message
  db.save

  erb :after_contacts
end
