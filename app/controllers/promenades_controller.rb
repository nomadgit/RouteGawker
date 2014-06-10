class PromenadesController < ApplicationController
  include HTTParty

  def index
    @promenades = Promenade.all()
    @promenade = Promenade.new()
  end

  def create
    @promenade = Promenade.new(promenade_params)
    if @promenade.save
      redirect_to promenade_path(@promenade)
    else
      render :index
    end
  end

  def show
    @promenade = Promenade.find(params[:id])
    google_directions_response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{@promenade.origin_location}&destination=#{@promenade.destination_location}&key=#{ENV['API_KEY']}")
    p google_directions_response.body
  end

  private

  def promenade_params
    params.require(:promenade).permit(:origin_location, :destination_location)
  end

end

# http://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=API_KEY
