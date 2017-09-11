class DevicesController < ApplicationController

  before_action :load_pattern

  def update
    Device.instance.active_pattern = Device.patterns[@pattern.name]
  end

  protected
  def load_pattern
    @pattern = Pattern.find(params[:pattern_id])
  end
end
