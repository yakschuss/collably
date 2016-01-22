class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show]
  after_action :assign_owner, only: [:create]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)


      logger.debug "Event should be valid: #{@event.valid?}"


      if @event.save
        flash[:notice] = "Your event was created successfully."
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

      def assign_owner
        created_event =  EventUserRole.find_by(event_id: @event.id)
        created_event.update_attribute(:role, "admin")
        Rails.logger.info "****controller****assign_user_role #{created_event.role.inspect}"
      end
end
