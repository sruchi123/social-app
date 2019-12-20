class MessagesController < ApplicationController
  before_action :authorize_request

  def index
    @user = User.find(params["user_id"])
    @conversation = Conversation.where(receiver_id: @user.id, sender_id: @current_user.id).first || Conversation.where(receiver_id: @current_user.id, sender_id: @user.id).first
    @conversation = Conversation.create(receiver_id: @user.id, sender_id: @current_user.id) unless @conversation.present?
    @conversation.messages rescue []
    render json: { conversation_id: @conversation.id, messages: @conversation.messages}, status: :ok
  end  

  def create
    conversation = Conversation.find(params["conversation_id"])
    @message = conversation.messages.build(sender_id: @current_user.id, text: params["message"])
    if @message.save
      ActionCable.server.broadcast "Conversation_#{conversation.id}", { body: @message, conversation_id: @message.conversation.id }
      render json: {messages: @message}, status: :ok
    else
      render json: {errors: @message.errors.full_message}
    end  
  end
    
end
