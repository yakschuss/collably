class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show]
  before_action :authorize_user, only: [:update_user, :invite_user]
  after_action :assign_owner, only: [:create]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)
      logger.debug "Event should be valid: #{@event.valid?}"

  #    @event.users.create(user: current_user, role: "admin", status: "accepted")

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
    @admins = @event.all_user_roles(@event.id, "1")
    @members = @event.all_user_roles(@event.id, "0")
    @invited = @event.all_user_roles(@event.id, "2")
  end

  def invite_user
    @event = Event.find(params[:id])


  #Need to validate uniqueness of user-event before running invite_the_user - right now, event_user_role - validate uniqueness of user_id throws a "That person isn't in the app error!"
  #would refactor if statement
    if @event.invite_the_user(params[:users][:email], @event)
      flash[:notice] = "Pending Invitation - waiting for user to accept."
      redirect_to @event
    else
      flash[:error] = "That person isn't in the app! Now's your chance to invite them!"
      render file: "devise/invitations/new"
    end
  end

  def update_user
    @making_admin = params[:boolean]
    @user = params[:user_id]
    @event = Event.find(params[:id])


    if @making_admin
      @event.update_user_role(@user)
        flash[:notice] = "Role Updated."
        redirect_to @event
    else
        flash[:error] = "Oops! Something went wrong. Try again."
        redirect_to @event
    end

  end


    private

      def event_params
        params.require(:event).permit(:title)
      end

      def assign_owner
        if @event.valid?
          created_event =  EventUserRole.find_by(event_id: @event.id)
          created_event.update_attributes(role: "admin", status: EventUserRole::ACCEPTED_STATUS)
        else
          flash[:error] = "Error saving event, please try again"
        end
      end

      def authorize_user
        @event = Event.find(params[:id])
        @admins = @event.all_user_roles(@event.id, "1")
        unless @admins.find { | user | user.id == current_user.id }
          flash[:error] = "You must be an admin to do that."
          redirect_to @event
        end
      end
end