class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)
    @eventuserrole =  EventUserRole.new(user: current_user, event: @event, role: 1)
      logger.debug "Event should be valid: #{@event.valid?}"
      logger.debug "EventUserRole should be valid: #{@eventuserrole.valid?}"

      if @event.save
        flash[:notice] = "Your Event was created"
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
