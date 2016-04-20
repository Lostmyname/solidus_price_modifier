SolidusPriceModifier
====================

This extension extracts a deprecated pricing hack from Solidus core. It consists of freedom patches on both
`Spree::Variant` and `Spree::LineItem`, which your app should implement.

The orginal extension point allowed for any freedom patch, while this extension only allows the most common one: Gift wrapping. Here's what your app has to do for this extension to work:

#### `Spree::Variant`

Provide a method that specifies the Gift wrap price modifier amount for different currencies. For example:

```ruby
Spree::Variant.class_eval do
  def gift_wrap_price_modifier_amount_in(_currency, value)
    value ? 2 : 0 # Two whatever currency added for gift wrapping
  end
end
```

#### `Spree::LineItem`

Provide a persisted something on the line item to hold whether it is to gift wrapped or not. You will probably
have done this by adding a column to the line item, which would make some sense. Here's a pure Ruby implementation:

```ruby
Spree::LineItem.class_eval do
  attr_accessor :gift_wrap
end
```

#### Configure your app accordingly

```ruby
Spree.config do |config|
  config.variant_pricer_class = Spree::Variant::GiftWrapPricer
end
```

If you need other price modifiers, like maybe `unbranded carton`, you need to write your own Pricer,
and you have to change the method names in the freedom patches on `Spree::LineItem` and `Spree::Variant`
`Spree::LineItem#unbranded_carton` / `Spree::Variant#unbranded_carton_price_modifier_amount_in`.

If you're actually using this, consider moving to a more sustainable approach. This extension will have support
only for Solidus `~> 1.3`. This extension is meant to ease your transition to better pricing solutions.

Installation
------------

Add solidus_price_modifier to your Gemfile:

```ruby
gem 'solidus_price_modifier'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g solidus_price_modifier:install
```

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

Copyright (c) 2016 [Stembolt], released under the New BSD License
