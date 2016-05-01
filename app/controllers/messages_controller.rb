class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def new ; end

  def create ; end

  def destroy ; end

end

