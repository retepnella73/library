class Book < ActiveRecord::Base
  attr_accessible :ISBN, :details, :edition, :first_published, :height, 
                  :page_count, :sort_title, :thickness, :title, :width, :year,
                  :publisher_id, :author_ids, :binding
                  
  belongs_to :publisher
  has_many :works
  has_many :authors, :through => :works
  
  
  validates_presence_of :title, :year, :ISBN, :publisher_id, :page_count
  validates_uniqueness_of :ISBN
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :year, :only_integer => true
#  validates_numericality_of :first_published, :only_integer => true
  
  before_save :generate_sort_title
  before_save :generate_sort_author
  before_save :generate_sort_publisher
  
  Binding = %W[Hardcover Paperback]
  
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
  
  def generate_sort_author
    self.sort_author = self.authors.sort_by{|author| author.last_name}.collect{|author| author.sort_name }.to_sentence
  end
  
  def generate_sort_publisher
    self.sort_publisher = self.publisher.sort_name
  end
  
end
