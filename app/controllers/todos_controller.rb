class TodosController < ApplicationController

  def create
    @event = Event.find(params[:id])
    @item = @event.items.create!(item_params)

    if @item.save
      flash[:notice] = "Your item was saved correctly"
    else
      flash[:error] = "oops, something didn't work there."
    end

  end

  def destroy
    @event = Event.find(params[:id])
    @item = @event.items.find(params[:id])

    if @item.destroy
      flash[:notice] = "Done!"
    else
      flash[:error] = "woops, try again"
    end
  end


  private

  def item_params
    params.require(:item).permit(:name)
  end
end
