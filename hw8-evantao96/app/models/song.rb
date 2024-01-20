class Song < ApplicationRecord
  belongs_to :artist
  validates :name, presence: true
  validates :name, uniqueness: { scope: :artist }
  validate :is_present, on: :create

  def is_present
    unless artist.nil? || artist.name.empty? || name.empty? 
      if song_search.empty?
        errors.add(:base, "Must be a valid song for the artist in Spotify")
      end
    end
  end

  def spotify_uri
    unless valid?
      nil
    else
      song = song_search.first
      song.uri
    end
  end

  private

  def song_search
    songs = RSpotify::Track.search(artist.name + " " + name)
    songs
  end
end
