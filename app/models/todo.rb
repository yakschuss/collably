class Todo < ActiveRecord::Base
  belongs_to :event


  default_scope {order('created_at DESC')}
end
