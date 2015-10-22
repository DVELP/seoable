# Seoable

Make your ActiveRecords SEO friendly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seoable'
```

Execute:

```bash
$ bundle
```

Run the `install generator`:

```sh
$ rails generate seoable:install
```

The generator:

* Creates an initializer to allow further configuration
* Creates a migration for seo_details table

## Configure

Override the defaults in `config/initializers/seoable.rb`:

```ruby
Seoable.configure do |config|
  config.default_title = 'My app name'
  config.default_description = 'The best app in the known universe'
  config.sluggable_attributes = [:title, :headline]
end
```

## Usage

Add `include Seoable::ActsAsSeoable` to any ActiveRecord you want to make Seoable:

```ruby
class Post < ActiveRecord::Base
  include Seoable::ActsAsSeoable
end
```

In your application layout file (probably `app/views/layouts/application.html.erb`):

Replace this line:

```erb
<title>ApplicationName</title>
```

With this line:

```erb
<title><%= seoable_title %></title>
```

Add the following line below `<title>`:

```erb
<meta name="description" content="<%= seoable_description %>" />
```

## Adding to existing app

If you’re adding seoable to existing app and want to generate SeoDetails for existing records, perform save for every model that includes ActsAsSeoable. You can do this from the console, runner or add a Rake task. For example:

```ruby
Post.find_each(&:save)
```

## Troubleshooting

### Column reference is ambiguous

If you see the error similar to `column reference "id" is ambiguous`, it’s due to including `seo_details` table through `default_scope`. To fix this, specify table name in your queries, like this:

```ruby
scope :only_big_ids, -> { where('"posts"."id" > 3') }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests.

To install the gem with your changes onto your local machine, run `rake install`.

## TODO

You’re more than welcome to send us pull-requests. Here’s the list of TODO items we’re looking to work on in the future:

* Add functionality to set default_title and default_description per model
* Add title_format configuration variable
* Create redirect on Seoable model save
* Add caching
* Integrate with ActiveAdmin (but have it optional)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DVELP/seoable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
