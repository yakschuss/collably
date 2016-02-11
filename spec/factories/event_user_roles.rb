FactoryGirl.define do
  factory :event_user_role do
    user_id 1
    event_id 1
    role 1
    status 1
    association :user
    association :event

  end

end
