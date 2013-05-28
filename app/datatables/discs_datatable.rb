class DiscsDatatable
  include Rails.application.routes.url_helpers
  
  delegate :params, :h, :link_to, to: :@view

  def initialize(view, base, edit_privilege, delete_privilege)
    @view = view
    @base = base
    @edit_privilege = edit_privilege
    @delete_privilege = delete_privilege
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @base.count,
      iTotalDisplayRecords: discs.total_count,
      aaData: data
    }
  end

private

  def data
    discs.map do |disc|
      if params[:controller] == 'artists'
        column2 = h(disc.disc_format.name)
      else
        column2 = h(disc.artist.full_name)
      end
      if @delete_privilege
        column4 = link_to('Edit', edit_disc_path(disc), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', disc, method: :delete, data: { confirm: "Are you sure you wish to delete '#{disc.title}'?" }, :class => 'btn btn-small btn-danger')
      elsif @edit_privilege
        column4 = link_to('Edit', edit_disc_path(disc), :class => 'btn btn-small btn-warning') 
      else
        column4 = ''
      end
      [
        h(disc.sort_title),
        h(disc.sort_artist),
        link_to(disc.title, disc),
        column2,
        h(disc.release_year),
        column4
      ]
    end
  end

  def discs
    @discs ||= fetch_discs
  end

  def fetch_discs
    # when artist.name...
    # Disc.order('artist.name asc')
    discs = @base.order("#{sort_column} #{sort_direction}").includes(:artist)
    
    discs = discs.page(page).per(per_page)
    if params[:sSearch].present?
      discs = discs.where("title like :search", search: "%#{params[:sSearch]}%")
    end
    discs
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[sort_title sort_artist title disc_format_id release_year]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
