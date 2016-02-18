class TodosController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @todo = @event.todos.create!(todo_params)

    if @todo.save
      flash[:notice] = "Your todo was saved correctly"
    else
      flash[:error] = "oops, something didn't work there."
    end
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:event_id])
    @todo = @event.todos.find(params[:id])

    if @todo.destroy
      flash[:notice] = "Done!"
    else
      flash[:error] = "woops, try again"
    end
    redirect_to @event
  end


  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
