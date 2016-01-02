require 'sinatra'
require './lib/movie'
require './lib/movie_store_yaml'

get('/movies') do
  # call erb with the symbol corresponding to ./views/xyz.erb
  # ie :xyz for the above, so never call this from lib or other folders :D
  request.env.each { |item, value| puts "#{item } : #{value }"}
  # by storing these as instance variables they will be
  # available in the erb files as well

  # lets create a yaml store
  @store = MovieStoreYAML.new('./mvstore.yml')

  # get all the movies in store, print em out in erb
  @movies = @store.get_movies
  # just to not break the existing erb, not needed otherwise
  @movie = @movies[3]
  # cant seem to call multiple files, will need to figure out how
  erb :index
end

get('/movies/new') do
  # calls ./views/new.erb
  erb :new
end

# lets create a page to store the details
post('/movies/create') do
  # lets create a yaml store
  @store = MovieStoreYAML.new('./mvstore.yml')

  # params has all the params :\
  puts "Received this: #{params.inspect}"
  @movie = Movie.new
  params.each do |key, value|
    # need the @#{key} cuz we are setting the title etc as @title = value
    # this is called metaprogramming i guess
    @movie.instance_variable_set("@#{key}", value)
  end
  #@movie now contains all necessary data except id
  @store.save_movie(@movie)
  "Received this: #{@movie.inspect}"
  # lets redirect to same page
  redirect('/movies/new')
end

# named params sound cool, pretty similar
# to regular params, but cooler :D
get('/movies/:id') do
  # lets create a yaml store
  @store = MovieStoreYAML.new('./mvstore.yml')
  "Got Movie #{params['id']}"
  # id stored as integed/fixnum, so convert to int
  @movie = @store.get_movie(params['id'].to_i)
  if @movie.nil?
    redirect '/movies'
  else
    # now call an erb to display this movie
    erb :displayMovie
  end
end