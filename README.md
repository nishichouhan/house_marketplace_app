# House Market Place Web application

House Market Place is an application where users can search, buy, and sell properties. It manages two roles: Admin and User. Admins have the ability to edit and delete property details.

# Features:

User Authentication: 
  Users can sign up, log in, and log out, forget password 

Property Listings: 
  Users can search for properties, view property details.
  USer can property from his favorite list
  USer can remove property from his favorite list

Admin Role Functionality: 
  Admins have the ability to edit and delete property details.

Responsive Design: 
  The application is designed to work seamlessly across devices of all sizes.

Requirements: 
  ruby 3.2.2
  rails 7.0.7
  postgres

#Setup Instructions:

  1. Clone your repository:

    `$ git clone https://github.com/nishichouhan/house_marketplace_app.git`

  2. Change into the app directory:

    `$ cd `

  3. Install the required gems:

    `$ bundle install`

  4. Create a `.env` file in the root directory. In this file, specify the values related to database configurations. 

  5. Create the database:

    `$ rails db:create`

  6. Migrate the database:

    `$ rake db:migrate`

  7. Start the server: 
    ` $ rails s` 