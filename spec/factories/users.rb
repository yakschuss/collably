FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user, class: 'User' do
    email
    password 'password'
    password_confirmation 'password'
  end
end
