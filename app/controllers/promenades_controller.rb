class PromenadesController < ApplicationController
  def index
    @promenade = Promenade.new()
  end
end