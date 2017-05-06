class FlavoursController < ApplicationController

def new
  @flavour = Flavour.new
end

def create
  @submitted_flavour = Flavour.new(filter_params)
  @submitted_flavour.supplier_id = current_supplier.id
  if @submitted_flavour.save
    
      # # ActionCable.server.broadcast(<stream>, <messages>)
      # ActionCable.server.broadcast 'flavour_update_channel',
      #                               content: @submitted_flavour,
      #                               user: current_user,
      #                               method: 'create'

      redirect_to "/suppliers/#{current_supplier.id}"
    end
end

private

def filter_params
  params.require(:flavour).permit(:name, :price, :image)
end

end
