module EventsHelper

  def resource_name
   :user
  end

  def resource
   @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

  def user_is_authorized_for_event?(event)
      #current_user && (current_user == post.user || current_user.invited?)
  end
end
