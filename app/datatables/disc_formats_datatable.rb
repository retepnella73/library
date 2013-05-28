class DiscFormatsDatatable
  include Rails.application.routes.url_helpers
  
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view, edit_privilege, delete_privilege)
    @view = view
    @edit_privilege = edit_privilege
    @delete_privilege = delete_privilege
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: DiscFormat.count,
      iTotalDisplayRecords: disc_formats.total_count,
      aaData: data
    }
  end

private

  def data
    if @delete_privilege
      disc_formats.map do |disc_format|
        [
          link_to(disc_format.name, disc_format),
          h(disc_format.discs.count),
          link_to('Edit', edit_disc_format_path(disc_format), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', disc_format, method: :delete, data: { confirm: "Are you sure you wish to delete '#{disc_format.name}'?" }, :class => 'btn btn-small btn-danger')
        ]
      end
    elsif @edit_privilege
      disc_formats.map do |disc_format|
        [
          link_to(disc_format.name, disc_format),
          h(disc_format.discs.count),
          link_to('Edit', edit_disc_format_path(disc_format), :class => 'btn btn-small btn-warning') 
        ]
      end
    else
      disc_formats.map do |disc_format|
        [
          link_to(disc_format.name, disc_format),
          h(disc_format.discs.count)
        ]
      end
    end
  end

  def disc_formats
    @disc_formats ||= fetch_disc_formats
  end

  def fetch_disc_formats
    disc_formats = DiscFormat.order("#{sort_column} #{sort_direction}")
    disc_formats = disc_formats.page(page).per(per_page)
    if params[:sSearch].present?
      disc_formats = disc_formats.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    disc_formats
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
