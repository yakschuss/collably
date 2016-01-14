class EventsController < ApplicationController
  before_action: :authenticate_user!, only: [:new, :create, :show]

  def new
  end

  def create
  end

  def show
  end

end
