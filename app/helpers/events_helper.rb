module EventsHelper
#methods allow custom devise sign_in forms in the event views
  def resource_name
   :user
  end

  def resource
   @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

end
