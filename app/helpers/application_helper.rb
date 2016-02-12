module ApplicationHelper

  helper_method :mailbox

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end


end
