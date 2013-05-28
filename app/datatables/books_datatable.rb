class BooksDatatable
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
      iTotalRecords: Book.count,
      iTotalDisplayRecords: books.total_count,
      aaData: data
    }
  end

private

  def data
    if @delete_privilege
      books.map do |book|
        [
          h(book.sort_title),
          h(book.sort_author),
          h(book.sort_publisher),
          link_to(book.title, book),
          h(book.authors.sort_by{|author| author.last_name}.collect{|author| author.full_name }.to_sentence(:last_word_connector => ' and ')),
          h(book.publisher.name),
          h(book.year),
          link_to('Edit', edit_book_path(book), :class => 'btn btn-small btn-warning') + ' ' + link_to('Delete', book, method: :delete, data: { confirm: "Are you sure you wish to delete '#{book.title}'?" }, :class => 'btn btn-small btn-danger')
        ]
      end
    elsif @edit_privilege
      books.map do |book|
        [
          h(book.sort_title),
          h(book.sort_author),
          h(book.sort_publisher),
          link_to(book.title, book),
          h(book.authors.sort_by{|author| author.last_name}.collect{|author| author.full_name }.to_sentence(:last_word_connector => ' and ')),
          h(book.publisher.name),
          h(book.year),
          link_to('Edit', edit_book_path(book), :class => 'btn btn-small btn-warning') 
        ]
      end
    else
      books.map do |book|
        [
          h(book.sort_title),
          h(book.sort_author),
          h(book.sort_publisher),
          link_to(book.title, book),
          h(book.authors.sort_by{|author| author.last_name}.collect{|author| author.full_name }.to_sentence(:last_word_connector => ' and ')),
          h(book.publisher.name),
          h(book.year)
        ]
      end
    end
  end

  def books
    @books ||= fetch_books
  end

  def fetch_books
    books = Book.order("#{sort_column} #{sort_direction}")
    
    books = books.page(page).per(per_page)
    if params[:sSearch].present?
      books = books.where("title like :search OR sort_author like :search OR sort_publisher like :search OR year like :search", search: "%#{params[:sSearch]}%")
    end
    books
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[sort_title sort_author sort_publisher title author publisher year]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
