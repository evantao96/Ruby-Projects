class Song
  attr_reader :name, :artist_name, :errors, :validators
  @all = []

  # Returns an array containing all songs
  def self.all
    @all
  end

  # Prompts the user for song information and creates and returns a new song with it
  def self.request_info
    puts 'What is the name of the song?'
    name = gets.strip
    puts "What is the artist's name?"
    artist_name = gets.strip

    Song.new(name: name, artist_name: artist_name)
  end

  # Gets input from the user, generates a song, and adds it to the all array if valid
  def self.add
    song = Song.request_info
    return unless song && song.valid?
    Song.all << song
    puts 'The song was added successfully'
  end

  # Prints out all songs if there are any
  def self.list
    if Song.all.empty?
      puts 'There are currently no songs'
    else
      Song.all.each.with_index(1) { |song, i| puts "#{i}. #{song.artist_name} - #{song.name}" }
    end
  end

  # Creates a song with the specified name and artist name
  # Initializes the song's error array and validators
  def initialize(params)
    @name = params[:name]
    @artist_name = params[:artist_name]

    @errors = []
    @validators = [validate_name, validate_artist_name, validate_uniqueness]
  end

  # Returns a lambda that adds an error if the song's name is empty
  def validate_name
    -> { errors << "The song's name must not be empty" if name.empty? }
  end

  # Returns a lambda that adds an error if the song's artist name is empty
  def validate_artist_name
    -> { errors << "The artist's name must not be empty" if artist_name.empty? }
  end

  # Returns a lambda that adds an error if a song with the same name and arist name
  # already exists
  def validate_uniqueness
    lambda do
      errors << 'You may not add a duplicate song' if Song.all.any? { |song| song.artist_name == artist_name && song.name == name }
    end
  end

  # Calls all of the validators and returns true if there were no errors
  def valid?
    @errors = []
    validators.each(&:call)
    errors.each { |error| puts error }
    errors.empty?
  end
end
