class ArtistsDatatable
  include Rails.application.routes.url_helpers
  
  delegate :params, :h, :link_to, to: :@view

  def initialize(view, edit_privilege, delete_privilege)
    @view = view
    @edit_privilege = edit_privilege
    @delete_privilege = delete_privilege
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Artist.count,
      iTotalDisplayRecords: artists.total_count,
      aaData: data
    }
  end

private

  def data
    artists.map do |artist|
      if @delete_privilege
        column4 = link_to('Edit', edit_artist_path(artist), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', artist, method: :delete, data: { confirm: "Are you sure you wish to delete '#{artist.full_name}'?" }, :class => 'btn btn-small btn-danger')
      elsif @edit_privilege
        column4 = link_to('Edit', edit_artist_path(artist), :class => 'btn btn-small btn-warning')
      else
        column4 = ''
      end
      [
        h(artist.name),
        link_to(artist.full_name, artist),
        h(artist.discs.count),
        h(artist.tracks.count),
        column4   
      ]
    end
  end

  def artists
    @artists ||= fetch_artists
  end

  def fetch_artists
    artists = Artist.order("#{sort_column} #{sort_direction}").includes(:discs, :tracks)
    
    artists = artists.page(page).per(per_page)
    if params[:sSearch].present?
      artists = artists.where("name like :search OR pre_name like :search OR first_name like :search", search: "%#{params[:sSearch]}%")
    end
    artists
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name full_name discs.count tracks.count]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
  
end
