class PicturesController < ApplicationController

  def addimage
    p params
    if params[:public_id].present?
      redirect_to root_path
    else
    @picture = Picture.new(picture_params)
    if params[:picture][:public_id]
      uploaded_file = params[:picture][:public_id].path
      cloudnary_file = Cloudinary::Uploader.upload(uploaded_file)
      @picture.supplier_id=current_supplier.id
      @picture.public_id = cloudnary_file['public_id']

      if @picture.save
        redirect_to root_path
      else
         render "suppliers/index"
    end
    end
    end
    end

    def profilepicture

    redirect_to root_path
    end

  private
  def picture_params
  params.require(:picture).permit(:public_id)
end





end
