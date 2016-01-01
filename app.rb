require 'sinatra'
require './lib/movie'

get('/movies') do
  # call erb with the symbol corresponding to ./views/xyz.erb
  # ie :xyz for the above, so never call this from lib or other folders :D
  request.env.each { |item, value| puts "#{item } : #{value }"}
  # by storing these as instance variables they will be
  # available in the erb files as well
  @movie = Movie.new
  @movie.title = 'TDKR'
  @movie.director = 'Chris Nolan'
  @movie.year = '2008'
  # cant seem to call multiple files, will need to figure out how
  erb :index
end