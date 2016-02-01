FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user, class: 'User' do
    first_name "Sir"
    last_name "Lancelot"
    email
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
  end
end
