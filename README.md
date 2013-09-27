# Rack Yandex Metrika

Simple Rack middleware to help injecting the Yandex Metrika tracking code in your website.

This middleware injects tracking code into the correct place of any request only when the response's `Content-Type` header contains `html` (therefore `text/html` and similar).

The project code is based on Rack Google Analytics project.

## Usage

#### Gemfile

```ruby
gem 'rack-yandex-metrika'
```

#### Sinatra

```ruby
## app.rb
use Rack::YandexMetrika, :counter_id => 00000000
```

#### Padrino

```ruby
## app/app.rb
use Rack::YandexMetrika, :counter_id => 00000000
```

#### Rails

```ruby
## environment.rb:
config.middleware.use Rack::YandexMetrika, :counter_id => 00000000
```

### Options

* `:async`                  -  sets to use asynchronous tracker (default: true)
* `:webvisor`               -  sets to use webvisor, ie tool for visitors behavior analysis (default: false)
* `:clickmap`               -  sets to collect statistics for ClickMap tool (default: false)
* `:trackLinks`             -  sets to collect statistics on using external links (default: false)
* `:accurateTrackBounce`    -  sets non-bounce visit time to 15 sec (default: false)
* `:trackHash`              -  sets to track hashes in URLs for AJAX sites (default: false)

If you are not sure what's best, go with the defaults, and read here if you should opt-out.

## Counter param

In your application controller, you may track visit params. For example:

```ruby
ya_metrika_counter_params("LoggedIn", {:option1 => "one", :option2 => "two"})
```
## Event Tracking

In your application controller, you may track an event. For example:

```ruby
ya_metrika_reach_goal("GOAL_NAME", {:option1 => "one", :option2 => "two"})
```

## Thread Safety

This middleware *should* be thread safe. Although my experience in such areas is limited, having taken the advice of those with more experience; I defer the call to a shallow copy of the environment, if this is of consequence to you please review the implementation.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 Ilya Konyukhov. See LICENSE for details.
With thanks to [Lee Hambley](https://github.com/leehambley) for Rack Google Analytics gem.
