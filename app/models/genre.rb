class Genre < ActiveRecord::Base
  attr_accessible :name, :parent_id
  
  scope :category, :conditions => ["id = parent_id"], :order => 'name'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :discs

  def is_category?
    parent_id == id
  end
  
  def get_genres_from_category
    Genre.find(:all, :conditions => ["parent_id = ? AND id != ?", self.id, self.id], :order => 'name')
  end

end
