class PointsController < ApplicationController
  before_action :set_point, only: [:show, :edit, :update, :destroy]

  # GET /points
  # GET /points.json
  def index
    @points = Point.all
#    @markers = Gmaps4rails.build_markers(@points) do |point, marker|
#      marker.title        'title'
#      marker.infowindow   'description'
#      marker.lat point.latitude
#      marker.lng point.longitude
##      marker.json({:id => point.id })
##      marker.picture({
##        "url" => "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
##        "width" =>  32,
##        "height" => 32}
##      )
#    end.to_json
    @markers = [].to_json
    @map_options = generate_map_options.to_json
  end

  # GET /points/1
  # GET /points/1.json
  def show
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(point_params)

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render :show, status: :created, location: @point }
      else
        format.html { render :new }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { render :show, status: :ok, location: @point }
      else
        format.html { render :edit }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_url, notice: 'Point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def generate_map_options
      {
        default_map_position:
          {
            coords:
              {
                latitude: 52.36132,
                longitude: 9.628606
              },
            default: true
          },
        infowindow_base_url: '',
        picture_base_url: '',
        default_zoom: 12
      }
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_point
      @point = Point.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def point_params
      params[:point]
    end
end
