class MessagesController < ApplicationController
  def create
    message_params = params[:message] || {}
    message = Message.create!(message_params)
    ApplicationMailer.new_message(message).deliver_now

    data = {}
    render json: data, status: 201
  end


end