class EventsController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(params[:title])
    @event.user = current_user
  end

  def show
    @event = Event.find(params[:id])
  end

end
