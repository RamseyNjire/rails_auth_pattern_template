# Rails Authentication Pattern

This project is a template for implementing single browser sessions in Rails.

## A Short Tour of the Rails Authentication Pattern

Note that isn't a production-grade, or even bug-free, implementation of authentication. A slew of solutions exist in the wild, such as [Devise](https://github.com/heartcombo/devise) and others. However, implementing a simple auth system from scratch is a great learning opportunity, and a chance to build a multi-part system in code. Most importantly, it's loads of fun! Below is a high-level breakdown of the different parts of the system and how I approached solving the problem.

### A Simple Problem with a Complex Solution

At a high level, you want users to be able to create accounts, login, and logout. Users should have passwords so they can exclusively access their accounts. Also, you want to have some stakes to this, so make it so that users cannot access some resources unless they are logged in. We also need some way to 'remember' users on a device, so they don't have to keep logging in every time they visit addresses within our application.

### The User Model and Controller

The user model will store the usernames and password digests. We won't actually store user passwords as that is insecure. Instead, we'll hash them using the BCrypt hashing library (which will also salt them and hash them multiple times for added security) and store the digests in the database. Each user will also have a session token set for them. This token will also be set in the browser cookies so that, every time they access the app, the token in the cookies will be used to search for the user in the database and load their data. When they log out, the session token will be reset in the database, so it can never be reused. The user will also have factory methods for generating session tokens for new users and finding users in the database using their credentials (username and password).


## The Session Resource

There won't be a session model. Instead, session tokens will be stored in the users table. What we'll have is a singular session resource and a sessions controller to handle requests to this endpoint. The controller will be able to create sessions, where it uses the username and password to find the user (via User::find_by_credentials). You will also be able to destroy sessions via a logout button, which is when the user's session token will be reset.

## The Application Controller

Since both the users and sessions controllers inherit from the Application controller, we will write common methods here, such as logging users in and out, setting the current_user variable for use in all views, and a method requiring users be logged in to be used as a callback to restrict access to certain resources. In this case, it is used to restrict access to the show action in the users controller, but it can be used almost anywhere.



The above is a high-level view. Feel free to peruse the user model and all three controllers to see the code. Unit and integration tests have also been written for all the different functionalities.


## Built With

- Ruby
- Ruby on Rails
- Postgresql
- RSpec
- Capybara
- HTML5

## Getting Started

- Clone the project to your local machine;
- `cd` into the project directory;
- Run `bundle install` to install the gems;
- Run `rails db:create`;
- Run `rails db:migrate`;
- Run `rails routes` if you need to see the available routes;
- To run tests, run `rspec`
- To see the views, run `rails server` and visit `localhost:3000` on your favorite browser;

## My Social Handles

- Github: [@RamseyNjire](https://github.com/RamseyNjire)
- Twitter: [@untakenramram](https://twitter.com/untakenramram)
- Linkedin: [Ramsey Njire](https://www.linkedin.com/in/ramsey-njire-51984931/)

## Attributions

Credit for the social image goes to [FLY:D](https://unsplash.com/photos/F7aZ8G7gGBQ?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink) on Unsplash.


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](lic.url) licensed.