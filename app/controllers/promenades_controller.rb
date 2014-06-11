
class PromenadesController < ApplicationController
  require 'json'
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
    stepwise_collection = get_data(@promenade)
    stepwise_collection.each do |current_vantage|
      create_vantage(current_vantage)
    end
    @vantages = Vantage.where(promenade_id: params[:id])
  end

  def get_data(promenade)
    data = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{@promenade.origin_location}&destination=#{@promenade.destination_location}&key=#{ENV['API_KEY']}&mode=walking").body
    p "*****" * 300
    p data
    p "&&&&&" * 300
    parsed_dataset = JSON.parse(data)
    parsed_dataset["routes"][0]["legs"][0]["steps"]
  end

  def create_vantage(current_vantage)
    vantage = Vantage.new
    vantage.latitude = current_vantage["start_location"]["lat"]
    vantage.longitude = current_vantage["start_location"]["lng"]
    vantage.promenade_id = params[:id]
    vantage.save
  end

  private

  def promenade_params
    params.require(:promenade).permit(:origin_location, :destination_location)
  end


end

# http://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=API_KEY
