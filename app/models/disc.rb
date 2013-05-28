class Disc < ActiveRecord::Base
  attr_accessible :artist_id, :catalog_number, :label_id, :release_year, 
                  :sort_title, :title, :toc, :genre_id, :cover, :disc_format_id
  
  belongs_to :artist
  belongs_to :label
  belongs_to :genre
  belongs_to :disc_format
  has_many :tracks
  
  validates_presence_of :title, :artist_id
#  validates_uniqueness_of :title

  before_save :generate_sort_title
  before_save :generate_sort_artist
  
  mount_uploader :cover, DiscCoverUploader
   
private
  
  def generate_sort_title
    if title.to(3) == 'The '
      self.sort_title = title.from(4)
    elsif title.to(1) == 'A '
      self.sort_title = title.from(2)
    else
      self.sort_title = title
    end
  end
  
  def generate_sort_artist
    self.sort_artist = self.artist.name
  end
  
end
