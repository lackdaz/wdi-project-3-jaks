class SessionsController < ApplicationController
  def new
  end
  def create
  consumer = Consumer.find_and_authenticate_consumer(consumer_params)

  if consumer
    session[:consumer_id] = consumer.id
    flash[:success] = "User logged in!!"
    p 'login successful'
    redirect_to consumers_url(@consumer)
  else

    p 'login fail'
    redirect_to login_path
      flash[:danger] = "Credentials Invalid!!"
  end
end

def destroy
  session[:consumer_id] = nil
  redirect_to login_path
  flash[:success] = "User logged out!!"
end

private

def consumer_params
  params.require(:consumer).permit(:email, :password)
end
end
