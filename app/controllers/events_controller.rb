class EventsController < ApplicationController
  inherit_resources
  actions :index, :show

  def show
    @event = Event.includes(:ticket_types).find(params[:id])
    show!
  end
end
