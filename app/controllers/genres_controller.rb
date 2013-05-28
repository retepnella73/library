class GenresController < ApplicationController
  # GET /genres
  # GET /genres.json
  def index
    @categories = Genre.category
    
    if params[:category_id]
      @category = Genre.find(params[:category_id])
    else
      @category = Genre.find(:first)
    end
    
    @genres = Genre.find(:all, :conditions => ["parent_id = ? AND id != ?", @category.id, @category.id])
    @total_records = @genres.size

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @genres }
      format.js
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @genre = Genre.find(params[:id])
    @category = Genre.find(@genre.parent_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/new
  # GET /genres/new.json
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/1/edit
  def edit
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(params[:genre])

    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.json { render json: @genre, status: :created, location: @genre }
      else
        format.html { render action: "new" }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /genres/1
  # PUT /genres/1.json
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      format.html { redirect_to genres_url }
      format.json { head :no_content }
    end
  end

#  def update_genres
#    @genres = Genre.find(:all, :conditions => ["parent_id = ? AND id != ?", 
#                         params[:category_select], params[:category_select]])
#    @category = Genre.find(params[:category_select])
#    @total_records = @genres.size
#    render :partial => 'genres', :object => @genres
#  end
end
