class Track < ActiveRecord::Base
  attr_accessible :artist_id, :disc_id, :duration, :mix, :number, :sort_title, :title

  before_save :generate_sort_title
  
  belongs_to :disc
  belongs_to :artist

  def title_and_mix
    unless mix.blank?
      return title.to_s + ' [' + mix.to_s + ']'
    else
      return title
    end
  end
  
  def minutes=(minutes)
    write_attribute(:duration, minutes.to_i * 60 + self.seconds.to_i)
  end

  def minutes
    read_attribute(:duration).to_i / 60
  end
  
  def seconds=(seconds)
    write_attribute(:duration, seconds.to_i + minutes.to_i * 60)
  end

  def seconds
    read_attribute(:duration).to_i % 60
  end

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

end

