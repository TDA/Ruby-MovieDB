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

  @movies = []
  @movies.push(@movie)
  @movie2 = Movie.new
  @movie2.title = 'HHVM'
  @movies << @movie2
  # cant seem to call multiple files, will need to figure out how
  erb :index
end

get('/movies/new') do
  # calls ./views/new.erb
  erb :new
end

# lets create a page to store the details
post('/movies/create') do
  # params has all the params :\
  "Received this: #{params.inspect}"
  @movie = Movie.new
  params.each do |key, value|
    # need the @#{key} cuz we are setting the title etc as @title = value
    # this is called metaprogramming i guess
    @movie.instance_variable_set("@#{key}", value)
  end
  "Received this: #{@movie.inspect}"
end