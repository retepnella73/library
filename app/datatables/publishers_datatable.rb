class PublishersDatatable
  include Rails.application.routes.url_helpers
  
  delegate :params, :h, :link_to, to: :@view

  def initialize(view, edit_privilege, delete_privilege)
    @view = view
    @edit_privilege = edit_privilege
    @delete_privilege = delete_privilege
  end

  def as_json(options = {})
    puts "As JSON : #{data}"
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Publisher.count,
      iTotalDisplayRecords: publishers.total_count,
      aaData: data
    }
  end

private

  def data
    if @delete_privilege
      publishers.map do |publisher|
        [
          h(publisher.sort_name),
          link_to(publisher.name, publisher),
          h(publisher.location),
          h(publisher.books.count),
          link_to('Edit', edit_publisher_path(publisher), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', publisher, method: :delete, data: { confirm: "Are you sure you wish to delete '#{publisher.name}'?" }, :class => 'btn btn-small btn-danger')
        ]
      end
    elsif @edit_privilege
      publishers.map do |publisher|
        [
          h(publisher.sort_name),
          link_to(publisher.name, publisher),
          h(publisher.location),
          h(publisher.books.count),
          link_to('Edit', edit_publisher_path(publisher), :class => 'btn btn-small btn-warning') 
        ]
      end
    else
      publishers.map do |publisher|
        [
          h(publisher.sort_name),
          link_to(publisher.name, publisher),
          h(publisher.location),
          h(publisher.books.count)
        ]
      end
    end
  end

  def publishers
    @publishers ||= fetch_publishers
  end

  def fetch_publishers
    publishers = Publisher.order("#{sort_column} #{sort_direction}").includes(:books)
    
    publishers = publishers.page(page).per(per_page)
    if params[:sSearch].present?
      publishers = publishers.where("name like :search OR location like :search", search: "%#{params[:sSearch]}%")
    end
    publishers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[sort_name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
