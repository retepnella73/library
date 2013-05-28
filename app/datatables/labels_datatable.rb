class LabelsDatatable
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
      iTotalRecords: Label.count,
      iTotalDisplayRecords: labels.total_count,
      aaData: data
    }
  end

private

  def data
    if @delete_privilege
      labels.map do |label|
        [
          link_to(label.name, label),
          h(label.discs.count),
          link_to('Edit', edit_label_path(label), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', label, method: :delete, data: { confirm: "Are you sure you wish to delete '#{label.name}'?" }, :class => 'btn btn-small btn-danger')
        ]
      end
    elsif @edit_privilege
      labels.map do |label|
        [
          link_to(label.name, label),
          h(label.discs.count),
          link_to('Edit', edit_label_path(label), :class => 'btn btn-small btn-warning') 
        ]
      end
    else
      labels.map do |label|
        [
          link_to(label.name, label),
          h(label.discs.count)
        ]
      end
    end
  end

  def labels
    @labels ||= fetch_labels
  end

  def fetch_labels
    labels = Label.order("#{sort_column} #{sort_direction}")
    labels = labels.page(page).per(per_page)
    if params[:sSearch].present?
      labels = labels.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    labels
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
