class Author < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :middle_name
  
  has_many :works
  has_many :books, :through => :works

  validates_presence_of :last_name
  validates_uniqueness_of :first_name, 
                          :scope => :last_name, 
                          :message => 'This name already exists!'
  
  def full_name
    fullname = ''
    fullname += first_name + ' ' unless first_name.blank?
    fullname += middle_name + ' 'unless middle_name.blank?
    fullname += last_name
  end
  
  def sort_name
    sortname = ''
    sortname += last_name
    sortname += ', ' + first_name unless first_name.blank?
    sortname += ' ' + middle_name unless middle_name.blank?
  end

end
