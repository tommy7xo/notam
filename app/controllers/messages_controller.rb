class MessagesController < ApplicationController

  def index
    @messages = Message.aerodrome_hours
  end

  def new ; end

  def create
    file_upload = FileUpload.new(params[:file])
    if file_upload.valid?
      file_upload.create_messages
      redirect_to messages_path, notice: "file uploaded"
    else
      redirect_to :back, alert: "something went wrong"
    end
  end

end

