class DiscFormatsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  
  filter_resource_access
  
  # GET /formats
  # GET /formats.json
  def index
    @disc_formats = DiscFormat.order('name').includes(:discs)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: DiscFormatsDatatable.new(view_context, 
                                                          (permitted_to? :edit, @disc_format), 
                                                          (permitted_to? :destroy, @disc_format)) }
    end
  end

  # GET /formats/1
  # GET /formats/1.json
  def show
    @disc_format = DiscFormat.find(params[:id])
    @discs = @disc_format.discs.includes(:artist)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: DiscsDatatable.new(view_context,
                                                    @disc_format.discs,
                                                    (permitted_to? :edit, @disc),
                                                    (permitted_to? :destroy, @disc)) }
    end
  end

  # GET /formats/new
  # GET /formats/new.json
  def new
    @disc_format = DiscFormat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disc_format }
    end
  end

  # GET /formats/1/edit
  def edit
    @disc_format = DiscFormat.find(params[:id])
  end

  # POST /formats
  # POST /formats.json
  def create
    @disc_format = DiscFormat.new(params[:disc_format])

    respond_to do |format|
      if @disc_format.save
        format.html { redirect_to @disc_format, notice: 'Format was successfully created.' }
        format.json { render json: @disc_format, status: :created, location: @format }
      else
        format.html { render action: "new" }
        format.json { render json: @disc_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /formats/1
  # PUT /formats/1.json
  def update
    @disc_format = DiscFormat.find(params[:id])

    respond_to do |format|
      if @disc_format.update_attributes(params[:disc_format])
        format.html { redirect_to @disc_format, notice: 'Format was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disc_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formats/1
  # DELETE /formats/1.json
  def destroy
    @disc_format = DiscFormat.find(params[:id])
    @disc_format.destroy

    respond_to do |format|
      format.html { redirect_to disc_formats_url }
      format.json { head :no_content }
    end
  end
end
