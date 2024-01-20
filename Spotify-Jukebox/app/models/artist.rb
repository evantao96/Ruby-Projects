class Artist < ApplicationRecord
  has_many :songs, inverse_of: :artist, dependent: :destroy
  accepts_nested_attributes_for :songs, reject_if: :all_blank
  validates :name, presence: true
  validates :name, uniqueness: true
  validate :is_present, on: :create

  def is_present
    unless name.empty?
      if artist_search.empty?
        errors.add(:base, 'Must be a valid artist in Spotify')
      end
    end
  end

  def related_artists
    unless valid?
      nil 
    else
      artist = artist_search.first
      related_artists = artist.related_artists
      names = related_artists.map(&:name)
      names.map! { |n| n.include?("(") ? n[0..n.index("(")-1].strip : n }
      names
    end
  end

  def top_tracks
    unless valid?
      nil 
    else
      artist = artist_search.first
      top_tracks = artist.top_tracks(:US)
      names = top_tracks.map(&:name)
      names
    end
  end

  private

  def artist_search
    artists = RSpotify::Artist.search(name)
    artists
  end
end
