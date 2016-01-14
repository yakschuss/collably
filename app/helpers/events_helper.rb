module EventsHelper

  def user_is_authorized_for_event?(event)
      #current_user && (current_user == post.user || current_user.invited?)
  end
end
