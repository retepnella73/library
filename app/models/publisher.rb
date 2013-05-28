class Publisher < ActiveRecord::Base
  
  attr_accessible :location, :name
  
  has_many :books
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  before_save :generate_sort_name
  
private
  
  def generate_sort_name
    if name.to(3) == 'The '
      self.sort_name = name.from(4)
    elsif name.to(1) == 'A '
      self.sort_name = name.from(2)
    else
      self.sort_name = name
    end
  end
  
end
