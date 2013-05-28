class Label < ActiveRecord::Base
  attr_accessible :name
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :discs
  
  def disc_count
    self.discs.count
  end

end
