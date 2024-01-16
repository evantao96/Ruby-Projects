class Artist < ApplicationRecord
  has_many :songs, inverse_of: :artist, dependent: :destroy

  def related_artists
  end

  def top_tracks
  end

  private

  def artist_search
  end
end
