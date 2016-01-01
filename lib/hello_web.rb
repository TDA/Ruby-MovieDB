require 'sinatra'

get('/hello') do
  'Hello Web!'
  erb :index
end