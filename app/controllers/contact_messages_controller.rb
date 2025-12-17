class ContactMessagesController < ApplicationController
  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(message_params)
    if @message.save
      redirect_to root_path, notice: "Повідомлення надіслано"
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
