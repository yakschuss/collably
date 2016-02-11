require 'faker'




users = User.all

(users.count+1).upto(5) do
    #another possible method for idempotency
    # (users.count..5).each do
    u =  User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "password",
        password_confirmation: 'password',
        confirmed_at: Time.now,
    )
    u.skip_confirmation!

end



events = Event.all


(events.count+1).upto(25) do
    event = Event.create!(
        title: Faker::Lorem.sentence
    )
    event.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    event.users << users.sample
end



puts "Seed Done."
puts "#{User.count} users exist"
puts "#{Event.count} items exist"
