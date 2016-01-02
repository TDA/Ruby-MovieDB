require 'yaml/store'

class MovieStoreYAML
  attr_accessor :store

  def initialize(file_name)
    @store = YAML::Store.new(file_name)
    p store
  end

  def save_movie(movie)
    @store.transaction do
      unless movie.id
        # movie.id doesnt exist, so retrieve highest (or 0 is
        # store empty), and then add 1 to it, and store
        # roots gives all the keys stored in the file in an array
        highest_id_in_store = @store.roots.max || 0
        movie.id = highest_id_in_store + 1
      end
      @store[movie.id] = movie
    end
  end

end

# test this
if __FILE__ == $0
  store = MovieStoreYAML.new('movies.yml')
  store.save_movie(Movie.new)
  p store
end