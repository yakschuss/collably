# Collably

Collably is a Event Planning Management Application. Users can collaborate with associated users on 1-off events, message each other, create shared todo lists, and invite new users.

The app is deployed on Heroku: https://collably.herokuapp.com/
The source code is here on GitHub: https://github.com/yakschuss/collably

# Features

+ Create an event, add Users, share todo lists, message entire event, or users individually
+ Appoint Users as administrators to share in responsibilities
+ Invite Users not present in app or event to join

# Setup and Configuration

**Languages and Frameworks**: Ruby on Rails and Bootstrap

**Ruby version 2.2.1**

**Databases**: SQLite (Test, Development), PostgreSQL (Production)

**Development Tools and Gems include**:

+ Devise for authentication
+ Simplecov for test suite success
+ Bullet for N + 1 Query detection

**Setup:**

+ Environment variables were set using Figaro and are stored in config/application.yml (ignored by git).

+ The config/application.example.yml file illustrates how environment variables should be stored.

**To run Collably locally:**

+ Clone the repository
+ Run bundle install
+ Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
+ Start the server using `rails server`
+ Run the app on `localhost:3000`
