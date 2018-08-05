class MessagesController < ApplicationController
  def create
    message_params = params[:message] || {}
    message = Message.new(message_params)
    message.referer = request.referer
    message.session_id = session.id

    if message.save
      message.notify_admin
    end
    data = {}
    render json: data, status: 201
  end


end