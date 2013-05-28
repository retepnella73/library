class Artist < ActiveRecord::Base
  attr_accessible :first_name, :name, :pre_name
  
  has_many :discs
  has_many :tracks

  validates_presence_of :name
  validates_uniqueness_of :first_name,
                          :scope => :name, 
                          :message => 'This name already exists!'

  def full_name
    fullname = ''
    fullname += pre_name + ' ' unless pre_name.blank?
    fullname += first_name + ' 'unless first_name.blank?
    fullname += name
  end
  
  def self.csv_header
    "pre_name,first_name,name".split(',')
  end
  
  def self.build_from_csv(row)
    # find existing customer from email or create new
#    cust = find_or_initialize_by_email(row[2])
    artist = Artist.new
    artist.pre_name = row[0]
    artist.first_name = row[1]
    artist.name = row[3]
    return artist
  end

end
