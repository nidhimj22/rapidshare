require 'securerandom'

class FileuploadsController < ApplicationController
  def index
    @fileuploads = Fileupload.where("user_id = ?", params[:user_id])
    @user = User.find(params[:user_id])
  end

  def new
    @fileupload = Fileupload.new
  end

  def create
    @fileupload = Fileupload.new(user_id: params[:user_id])
    @fileupload.uploaded_file = params[:fileupload][:uploaded_file] if not params[:fileupload].nil?

    if @fileupload.save
      flash[:notice] = "File uploaded!"
      redirect_to user_fileuploads_path(params[:user_id])
    else
      flash[:error] = "File upload failed. Please retry."
      render 'new'
    end
  end

  def destroy
    fileupload = Fileupload.find(params[:id])

    begin
      fileupload.destroy
    rescue
      # If the file is not present on the file system but 
      # if its present in the active record, skip model callback
      fileupload.delete
    end
    flash[:notice] = "The file has been deleted"
    redirect_to user_fileuploads_path(params[:user_id])
  end

  def download
    @fileupload = Fileupload.find(params[:id])
    send_file(@fileupload.file_path, :filename=>@fileupload.file_name)
  end
end
