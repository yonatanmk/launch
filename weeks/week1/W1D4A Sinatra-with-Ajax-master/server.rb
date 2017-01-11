require 'sinatra'
require 'json'
require 'pry'

thoughts = [
  "I think you are the coolest cat on the planet",
  "At least your mother loved you",
  "Don't listen to Sebastian, you smell great!",
  "KILL THEM ALL!",
  "Puppies are pretty rad I guess",
  "Bellybuttons are the weirdest",
  "My spirit animal is my english teacher"
]

get '/' do
  erb :index
end

get '/thoughts/random.json' do
  content_type :json
{ thought: thoughts.sample }.to_json
end

get "/items" do
  { items: ["thing"] }.to_json
end
