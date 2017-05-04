class ConsumersController < ApplicationController
    before_action :is_authenticated, only: [:index,:show,:edit]

  def index
  end

def new
  @consumer = Consumer.new
end

def create
  p consumer_params

  @cosumer = Consumer.new(consumer_params)

  @consumer = Consumer.new(consumer_params)
  if @consumer.update(consumer_params)
    p 'updated'
    render :show
  else
    p 'failed'
    redirect_to edit_consumer_path
  end
end


def destroy
  @consumer = Consumer.find(params[:id])
  if @consumer.destroy
    p 'deleted'
    redirect_to new_consumer_path
  else
    redirect_to consumers_url(@consumer)
  end


end

  private
  def consumer_params
  params.require(:consumer).permit(:first_name, :last_name, :email, :password)
  end

end
