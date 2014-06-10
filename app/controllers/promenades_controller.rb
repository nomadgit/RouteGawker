class PromenadesController < ApplicationController
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
  end

  private

  def promenade_params
    params.require(:promenade).permit(:origin_location, :destination_location)
  end

end