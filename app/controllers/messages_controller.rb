class MessagesController < ApplicationController
  layout 'message', only: [:show]
  skip_before_action :authenticate_user!, only: [:show]

  before_action :normalize_body,     only: [:create]
  before_action :find_by_identifier, only: [:show]
  before_action :set_conversation,   only: [:create, :portion]

  def create
    @message = @conversation.messages.new(message_params.merge(user: current_user))
    respond_to do |format|
      if @message.save
        format.json { render json: @message, status: 200 }
      else
        format.json { render json: @message, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer }
      end
    end
  end

  def portion
    @messages = @conversation.messages.portion(params[:range].to_i, params[:iteration].to_i)
    render json: @messages
  end

  def show
  end

  private

  def find_by_identifier
    @message = Message.find_by(identifier: params[:identifier])
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :encrypted_body, :conversation_id)
  end

  def normalize_body
    message_params[:body].strip!
  end
end
