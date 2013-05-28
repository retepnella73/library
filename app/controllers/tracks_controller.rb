require 'csv'

class TracksController < ApplicationController
  
  before_filter :get_disc
  before_filter :authenticate_user!, :except => [:index, :show]
  
  filter_access_to :all
  filter_access_to :import, :require => :create
  
  
  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = @disc.tracks.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tracks }
    end
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @track = @disc.tracks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @track }
    end
  end

  # GET /tracks/new
  # GET /tracks/new.json
  def new
    @track = @disc.tracks.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @track }
    end
  end

  # GET /tracks/1/edit
  def edit
    @track = @disc.tracks.find(params[:id])
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = @disc.tracks.build(params[:track])

    respond_to do |format|
      if @track.save
        format.html { redirect_to disc_tracks_path(@disc), notice: 'Track was successfully created.' }
        format.json { render json: @track, status: :created, location: @track }
      else
        format.html { render action: "new" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tracks/1
  # PUT /tracks/1.json
  def update
    @track = @disc.tracks.find(params[:id])

    respond_to do |format|
      if @track.update_attributes(params[:track])
        format.html { redirect_to disc_tracks_url(@disc), notice: 'Track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track = @programme.tracks.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to tracks_url }
      format.json { head :no_content }
    end
  end
  
  def import
    if request.post? && params[:file].present?
      n, errs = 0, []

      csv_options = {:headers => :first_row, :return_headers => true, :col_sep => ",", :row_sep => :auto }
      CSV.parse(params[:file].read, csv_options) do |row|
        next if row.header_row?
        track = Track.new
        track.title = row['title']
#        track.sort_title = row['sort_title']
        track.duration = row['duration']
        track.mix = row['mix']
        track.number = row['number']
        track.disc_id = row['disc_id']
        track.artist_id = row['artist_id']
        # Save upon valid 
        # otherwise collect error records to export
        if track.valid?
          track.save
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
        flash[:notice] = I18n.t('track.import.success')
        redirect_to import_disc_tracks_path(@disc) #GET
      end      
    end
  end

private
  
  def get_disc
    @disc = Disc.find(params[:disc_id])
  end

end
