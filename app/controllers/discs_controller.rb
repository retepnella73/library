class DiscsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  filter_resource_access
  
  # GET /discs
  # GET /discs.json
  def index
    @discs = Disc.order('sort_title').includes(:artist).page(1).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: DiscsDatatable.new(view_context, 
                                                    Disc,
                                                    (permitted_to? :edit, @disc), 
                                                    (permitted_to? :destroy, @disc)) }
      format.js
      format.xml { render :xml => @discs.to_xml }
    end
  end

  # GET /discs/1
  # GET /discs/1.json
  def show
    @disc = Disc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @disc }
    end
  end

  # GET /discs/new
  # GET /discs/new.json
  def new
    @disc = Disc.new
    @categories = Genre.category
    
    if params[:category_id]
      @selected_category = Genre.find(params[:category_id])
      @genres = Genre.find(:all, :conditions => ["parent_id = ? AND id != ?", @selected_category, @selected_category])
    else
      @genres = Genre.find(:all)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disc }
      format.js
    end
  end

  # GET /discs/1/edit
  def edit
    @disc = Disc.find(params[:id])
    @categories = Genre.category
    if params[:category_id]
      @selected_category = Genre.find(params[:category_id])
    else
      @selected_category = Genre.find(@disc.genre.parent_id)
    end
       
    @genres = Genre.find(:all, :conditions => ["parent_id = ? AND id != ?", @selected_category, @selected_category])
    logger.debug "@selected_category: #{@selected_category.inspect}" 
    respond_to do |format|
      format.html
      format.js
    end
 end

  # POST /discs
  # POST /discs.json
  def create
    @disc = Disc.new(params[:disc])

    respond_to do |format|
      if @disc.save
        format.html { redirect_to @disc, notice: 'Disc was successfully created.' }
        format.json { render json: @disc, status: :created, location: @disc }
      else
        format.html { render action: "new" }
        format.json { render json: @disc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /discs/1
  # PUT /discs/1.json
  def update
    @disc = Disc.find(params[:id])

    respond_to do |format|
      if @disc.update_attributes(params[:disc])
        format.html { redirect_to @disc, notice: 'Disc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discs/1
  # DELETE /discs/1.json
  def destroy
    @disc = Disc.find(params[:id])
    @disc.destroy

    respond_to do |format|
      format.html { redirect_to discs_url }
      format.json { head :no_content }
    end
  end
  
end
