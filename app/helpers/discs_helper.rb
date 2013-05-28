module DiscsHelper

  def category_name(disc)
    if disc.genre.parent_id
      return Genre.find_by_id(disc.genre.parent_id).name
    end
  end

  def cover_thumb(disc)
    if disc.cover_url
      link_to image_tag(disc.cover_url(:thumb).to_s), 
              disc.cover_url.to_s,
              { :rel => 'lightbox', :title => (disc.title) }
    end
  end

  def cover_for(disc, size = :medium)
    if disc.cover_url
      cover_image = disc.cover_url(size).to_s
      link_to image_tag(cover_image), disc.cover_url.to_s, {:rel => 'lightbox[disc]', :title => (disc.artist.full_name + ' - ' + disc.title), :class => size.to_s}
    else
      image_tag("blank-cover-#{size}.jpg")
    end
  end

end
