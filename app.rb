require 'sinatra'
require './lib/movie'

get('/movies') do
  # call erb with the symbol corresponding to ./views/xyz.erb
  # ie :xyz for the above, so never call this from lib or other folders :D
  request.env.each { |item, value| puts "#{item } : #{value }"}
  erb :index
end