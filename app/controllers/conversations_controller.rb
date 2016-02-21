class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def create
    if params["event_message"] == "1"
      redirect_to send_message_event_path(params[:conversation_params])
    else
      recipients = User.where(id: conversation_params[:recipients])
      conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
      flash[:success] = "Your message was sent successfully!"
      redirect_to conversation_path(conversation)
    end
  end

  def show
    @receipts = conversation.receipts_for(current_user)
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:success] = "Your message was sent successfully!"
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:event_message, :subject, :body, recipients: [])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end
end
