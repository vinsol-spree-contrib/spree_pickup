SpreePickup
=============

SpreePickup is an extension and one stop solution to integrate pickup functionality in a spree application.

* This extension allows to add pickup location to your orders. The user can choose from the list of pickup locations.

* When a user chosses pickup as the mode of delivery then the shipping address of the order is pickup location itself.

* This extension adds new states `ready_for_pickup` and `shipped_for_pickup`. An order is in `read_for_pickup` when the order has arrived at pickup location while order is in `shipped_for_pickup` state when the order has been shipped from warehouse/store to the pickup location.

## Installation

1. Just add this line to your `Gemfile`:
  ```ruby
  gem 'spree_pickup', github: 'vinsol/spree_pickup'
  ```

2. Execute the following commands in respective order:

   ```ruby
    bundle install
    ```

   ```ruby
    bundle exec rails g spree_pickup:install
    ```

3. Working
---

* A gift card is created by default when you seed data. Admin can also create `gift card` through

    `Admin -> Products -> New`

    while creating a new gift card, check `is gift card`, which means the product is gift card.
* Once gift card is created, it is visible to customer.
* One needs to add gift card shipping category to a shipping method to purchase a gift card.
* When purchasing a gift card, a form is rendered to user, on which one can fill the `value`,`email`, `recipient name` and `note`. Once your order-payment is successfully captured, the gift card will be send to the email mentioned in gift card form.
* The `Email` will contain details of gift card, amount, code, sender's email and note.
* One can redeem the gift card by applying gift card code at payment step.

**Here is a detailed article with screenshot http://vinsol.com/spreecommerce-gift-card**
Contributing
------------

1. Fork the repo.
2. Clone your repo.
3. Run `bundle install`.
4. Run `bundle exec rake test_app` to create the test application in `spec/test_app`.
5. Make your changes.
6. Ensure specs pass by running `bundle exec rspec spec`.
7. Submit your pull request.

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_pickup/factories'
```
Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2014 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License

