class TodosController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @todo = @event.todos.create!(todo_params)
    @new_todo = Todo.new
    if @todo.save
      flash[:notice] = "Your todo was saved correctly"
    else
      flash[:error] = "oops, something didn't work there."
    end


    respond_to do |format|
       format.html
       format.js
     end

  end

  def destroy
    @event = Event.find(params[:event_id])
    @todo = @event.todos.find(params[:id])

    if @todo.destroy
      flash[:notice] = "Done!"
    else
      flash[:error] = "woops, try again"
    end


    respond_to do |format|
       format.html
       format.js
     end

  end


  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
