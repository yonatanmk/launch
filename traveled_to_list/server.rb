require 'sinatra'
require 'pry'

get '/' do
  redirect "/traveled_to_list"
end
