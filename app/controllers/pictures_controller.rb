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
    def get_profilepicture
      render 'picture/show_image'
    end
    def update_profilepicture
      puts "PIC #{current_supplier.pictures.inspect}"
      current_supplier.pictures.each do |picture|
        picture.profilepic = false
        picture.save
      end
      # p params['picture']['profilepic']
      @picture = Picture.find(profilepic_params['profilepic'])
      @picture.profilepic = true
      @picture.save
      redirect_to root_path
    end
    def delete_profilepicture
      @profilepicture =Picture.find(params[:id])
      p @profilepicture.destroy
      render 'picture/show_image'
    end
  private
  def picture_params
    params.require(:picture).permit(:public_id)
  end
  def profilepic_params
    params.require(:picture).permit(:profilepic)
  end
end
