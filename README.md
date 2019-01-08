# README

## Context
This is a final project for the second module of the Back End Engineering Program at Turing School of Software and Design. It was built on an existing code base that an instructor created. My two extensions were:

1. Giving users the ability to rate an item that has been successfully purchased.

2. Adding slugs to users and items.

## Learning Goals

##### For Users Can Rate Items:
* Database relationships
* Rails development (including routing)
* Software Testing
* HTML/CSS styling and layout

##### For Slugs:
* Additional database migrations
* ActiveRecord
* Rails routing
* Namespacing
* Software Testing


## Getting Started && Prerequisites

You will need Rails v 5.1.
```
gem install rails -v 5.1
```
Clone down this repo!

```
git clone https://github.com/mgoodhart5/little_shop_base_small
```

### Installing

From your terminal, navigate into the little_shop directory:

```
cd little_shop_base_small
```

Make sure your gemfile is up to date:

```
bundle
bundle update
```
Establish a database:

```
rake db:{drop,create,migrate,seed}
```
Start your server:

```
rails s
```

Open your browser (best functionality in Chrome).

`localhost:3000`

Welcome to our dev environment!


## Running the tests

Your location should be the root directory of the project (`little_shop_base_small`).

From the command line run `rspec`
(This can take a moment)

`Green` is passing.
`Red` is failing.

`Rspec`, `capybara`, and `shoulda-matchers` were used for testing, as well as the `FactoryBot` and `Faker` gems.

## Extension Specifics

* Users Can Rate Items:
Users cannot rate items from orders that have been cancelled. Users can write one rating per item per order. Users can disable any rating (I also added that they can re-enable them); they can also delete a review whether it is enabled or disabled. Ratings have a title, description, and a rating from 1-5

* Slugs:
All paths for items and users should change from using the id to using a slug. A slug needs to be saved in the `users` and `items` tables. Use the email address for a user, ensure uniqueness on an item slug. No gems are to be used.
