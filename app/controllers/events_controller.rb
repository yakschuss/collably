class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
      logger.debug "Event should be valid: #{@event.valid?}"

      if @event.save
        flash[:notice] = "event was created"
        redirect_to @event
      else
        flash[:error] = "Error saving event, please try again"
        render :new
      end
  end

  def show
    @event = Event.find(params[:id])
  end


    private

      def event_params
        params.require(:event).permit(:title)
      end
end