# README
# Gems used in this project:
- bootstrap: to beautify the views
- devise: to handle user authentication
- Hirb: to beautify the console prints of db tables
- pundit: to handle user authorization
- Cloudinary: all the images are remotely uploaded to cloud
- sidekiq: for active job
- faker: for data seeding
- ransack: for generating search engine
***
# Ruby and Rails version
1. Ruby Version = ruby 2.7.1
2. Rails Version = Rails 5.2.8.1
3. Database postgres (PostgreSQL) 14.5
4. Bundler version 2.1.4
***
# Setup rails app
1. All the gems mentioned above and dependencies should be installed first. Install ruby,rails and install all the gems installed above by bundle install
2. Run bundle by going to the root directory so that all the gems are installed
3. Run `bundle exec db:setup` to setup the database. It will load the schema, run all the migrations and load seed data into db.
4. 4 new users are seeded.
5. Edit the credentials.yml file to add all your credentials there.

# Start the project
1. To start the project, run the command `bundle exec rails server` to start the server and then go to the ://localhost:3000
2. https://salty-falls-03005.herokuapp.com , Heroku link
# InstagramClone-RubyonRails
