class Song < ApplicationRecord
  belongs_to :artist

  def spotify_uri
  end

  private

  def song_search
  end
end
