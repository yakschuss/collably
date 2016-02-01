FactoryGirl.define do
  factory :event do
    title "MyString"

    after(:create) do |event|
      event.users << FactoryGirl.create(:user)
    end
      end

end
