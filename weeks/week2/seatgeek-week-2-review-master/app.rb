require "sinatra"

set :bind, '0.0.0.0'  # bind to all interfaces

get "/" do
  "Hot Events in MA"
  erb :index
end
