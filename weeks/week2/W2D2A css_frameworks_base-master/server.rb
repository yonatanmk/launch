require 'sinatra'

get '/' do
  erb :index
end

get '/bloop' do
  erb :bloop
end
