class UsersController < ApplicationController
def show
render  "users/registrations/show"
end

def new
  render "users/registrations/new"
end


end
