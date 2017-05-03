class ConsumersController < ApplicationController
    before_action :is_authenticated, only: [:index,:show,:edit]

  def index
  end

def new
  @consumer = Consumer.new
end

def create
  @consumer = Consumer.new(consumer_params)

  if
   @consumer.save
    flash[:success] = "Account Created. Please Login"
    p params
    p 'successful signup'
    redirect_to login_path
  else
    p 'failed signup'
    flash[:danger] = "Wrong Credentials"
    render :new


  end
end

def show
    @consumer = Consumer.find(params[:id])
    if @current_user.id == @consumer.id
      render 'show'
    else redirect_to :consumers
    end

end

def edit
  @consumer = Consumer.find(params[:id])
  p 'editing route'
  if @current_user == @consumer
    render 'edit'
  else
    p @current_user
    p @consumer
     redirect_to :consumers
  end



end

  def update
  @consumer = Consumer.find(params[:id])

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
