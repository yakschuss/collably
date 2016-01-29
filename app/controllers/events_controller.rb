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

  def invite_user
    @event = Event.find(params[:id])
    if @event.invite_the_user(params[:users][:email], @event) #not getting the user.email parameter from user/_form.html.erb
      flash[:notice] = "User invited"
      redirect_to @event
    else
      flash[:error] = "Unable to invite User"
      render :show
    end
  end


    private

      def event_params
        params.require(:event).permit(:title)
      end

      def assign_owner
        if @event.valid?
          created_event =  EventUserRole.find_by(event_id: @event.id)
          created_event.update_attribute(:role, "admin")
          Rails.logger.info "****controller****assign_user_role #{created_event.role.inspect}"
        else
          flash[:error] = "Error saving event, please try again"
        end
      end

end
