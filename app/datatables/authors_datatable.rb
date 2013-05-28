class AuthorsDatatable
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
      iTotalRecords: Author.count,
      iTotalDisplayRecords: authors.total_count,
      aaData: data
    }
  end

private

  def data
    if @delete_privilege
      authors.map do |author|
        [
          h(author.sort_name),
          link_to(author.full_name, author),
          h(author.books.count),
          link_to('Edit', edit_author_path(author), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', author, method: :delete, data: { confirm: "Are you sure you wish to delete '#{author.full_name}'?" }, :class => 'btn btn-small btn-danger')
        ]
      end
    elsif @edit_privilege
      authors.map do |author|
        [
          h(author.sort_name),
          link_to(author.full_name, author),
          h(author.books.count),
          link_to('Edit', edit_author_path(author), :class => 'btn btn-small btn-warning') 
        ]
      end
    else
      authors.map do |author|
        [
          h(author.sort_name),
          link_to(author.full_name, author),
          h(author.books.count)
        ]
      end
    end
  end

  def authors
    @authors ||= fetch_authors
  end

  def fetch_authors
    # when artist.name...
    # Disc.order('artist.name asc')
    authors = Author.order("#{sort_column} #{sort_direction}").includes(:books)
    
    authors = authors.page(page).per(per_page)
    if params[:sSearch].present?
      authors = authors.where("first_name like :search OR middle_name like :search OR last_name like :search", search: "%#{params[:sSearch]}%")
    end
    authors
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[last_name middle_name first_name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
