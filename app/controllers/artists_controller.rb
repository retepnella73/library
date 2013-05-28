require 'csv'

class ArtistsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  filter_access_to :all
  filter_access_to :import, :require => :create
  
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.order('name').includes(:discs, :tracks).page(1).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ArtistsDatatable.new(view_context, 
                                                      (permitted_to? :edit, @artist), 
                                                      (permitted_to? :destroy, @artist)) }
      format.js
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id], :include => :discs)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: DiscsDatatable.new(view_context, 
                                                    @artist.discs,
                                                    (permitted_to? :edit, @disc), 
                                                    (permitted_to? :destroy, @disc)) }
    end
  end

  # GET /artists/new
  # GET /artists/new.json
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "new" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end
  
  def import
    if request.post? && params[:file].present?
      n, errs = 0, []

      csv_options = {:headers => :first_row, :return_headers => true, :col_sep => ",", :row_sep => :auto }
      CSV.parse(params[:file].read, csv_options) do |row|
        next if row.header_row?
        artist = Artist.new
        artist.pre_name = row['pre_name']
        artist.first_name = row['first_name']
        artist.name = row['name']
        # Save upon valid 
        # otherwise collect error records to export
        if artist.valid?
          artist.save
        else
          errs << row
        end
      end
      if errs.any?
        errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv"
        errs.insert(0, Artist.csv_header)
        errCSV = CSV.generate do |csv|
          errs.each {|row| csv << row}
        end
        send_data errCSV,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{errFile}.csv"
      else
        flash[:notice] = I18n.t('artist.import.success')
        redirect_to import_artists_path #GET
      end      
    end
  end
  
end
