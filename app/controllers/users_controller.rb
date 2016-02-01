class UsersController < ApplicationController
#   before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:id])
  end

  def decline_invite
      @user = User.find(params[:id])
      @event = Event.find(params[:id])

      if @user.turn_down_invite(@event)
        flash[:notice] = "Invite Declined"
        redirect_to @user
      else
        flash[:error] = "Unable to process - please try again"
        render :show
      end
  end

  def accept_invite
    @user = User.find(params[:id])
    @event = Event.find(params[:id])
    if @user.accept_the_invite(@event)
      flash[:notice] = "Welcome!"
      redirect_to event_path(@event.id)
    else
      flash[:error] = "Oops! That didn't work. Please try again."
      render :show
    end
  end

end
