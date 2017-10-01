class RenderersController < ApplicationController

  before_action :load_renderer

  def show
    @patterns = Pattern.active
    render :edit
  end

  def update
    @renderer.update(params.require(:renderer).permit(:pattern_id, :leds_on))

    redirect_back fallback_location: root_path
  end

  def toggle
    @renderer.leds_on = !@renderer.leds_on
    redirect_back fallback_location: root_path
  end

  protected

  def load_renderer
    @renderer = Renderer.instance
  end
end
