require 'sinatra'
require 'sinatra/sequel'

if ENV["RACK_ENV"] == 'development'
  set :database, 'sqlite://database.db'
elsif ENV["RACK_ENV"] == 'production'
  #
end

if !database.table_exists?('users')
  migration "create users table" do
    database.create_table :users do
      primary_key :id
      string      :username
      string      :email
      index       :username, :unique => true
    end
  end
end

if !database.table_exists?('scores')
  migration "create the scores table" do
    database.create_table :scores do
      primary_key :id
      integer     :user_id
      integer     :score
    end
  end
end