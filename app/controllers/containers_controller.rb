class ContainersController < ApplicationController

def new
  @container = Container.new
end

def create
  @submitted_container = Container.new(filter_params)
  @submitted_container.supplier_id = current_supplier.id
  if @submitted_container.save
    redirect_to "/suppliers/#{current_supplier.id}"
  end
end

private

def filter_params
  params.require(:container).permit(:name, :price)
end
end
