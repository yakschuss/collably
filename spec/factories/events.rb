FactoryGirl.define do
  factory :event do
    title "MyString"

    after(:create) do |event|
      event.users << FactoryGirl.create(:admin_user)
    end
      end

end
