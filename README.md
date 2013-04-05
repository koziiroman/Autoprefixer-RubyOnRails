# Autoprefixer Rails

Parse CSS and add prefixed properties and values when it really necessary
for selected browsers.

This gem provides Ruby and Ruby on Rails integration with
[Autoprefixer](https://github.com/ai/autoprefixer) JS library.

Write your CSS usual code without prefixes (forget about them at all,
Autoprefixer will think for you) in `app/assets/stylesheets`:

```css
a {
    transition: transform 1s
}
```

Autoprefixer will see in own database (from [Can I Use](http://caniuse.com/))
with current browser statistics and properties support and adds only
actual prefixes by Assets Pipeline:

```css
a {
  -webkit-transition: -webkit-transform 1s;
  -ms-transition: -ms-transform 1s;
  -o-transition: -o-transform 1s;
  -webkit-transition: transform 1s;
  -o-transition: transform 1s;
  transition: transform 1s
}
```

You can use it with Sass, LESS or Stylus, because Assets Pipeline has a nice
architecture cascade filters. Just write CSS without prefixes in Sass syntax:

```sass
a
  transition: transform 1s
```

## Features

* You write normal CSS (or use Autoprefixer after Sass, Stylus
  or another preprocessor).
* You write normal properties (not special mixins), so you don’t need to
  remember which properties needs to be prefixed.
* Autoprefixed uses only really necessary prefixes. You set browsers (by default
  last 2 version for each browsers). Do you know, that prefixes for
  `border-radius` [is not necessary](http://caniuse.com/border-radius)
  for a long time?
* Properties and browsers database is updated automatically
  (from [Can I Use](http://caniuse.com/)), so prefixes will be always actual
  (scripts don’t have holidays and work).
* It also adds prefixes to the values. For example, to `calc(1em + 5px)` or
  to properties names in `transition`.

## Usage

### Ruby on Rails

Add `autoprefixer-rails` gem to `Gemfile` and write CSS in usual way:

```ruby
gem "autoprefixer-rails"
```

If you need to specify browsers actual for your project (by default, it’s last
2 versions of each browser), you can
[write them](https://github.com/ai/autoprefixer#browsers)
to `config/autoprefixer.yml`:

```yaml
- "last 1 version"
- "> 1%"
- "ie 8"
```

### Sprockets

If you use Sinatra or other non-Rails framework with Sprockets,
just connect your Sprockets environment to Autoprefixer and write CSS
in usual way:

```ruby
assets = Sprockets::Environment.new do |env|
  # Your assets settings
end

require "autoprefixer-rails"
AutoprefixerRails.install(assets)
```

You can set arrays of actual browsers as second argument in `install` method.

### Ruby

If you need Autoprefixer in plain Ruby code, it’s very easy:

```ruby
require "autoprefixer-rails"
prefxied = AutoprefixerRails.compile(css)
```

You can set arrays of actual browsers as second argument in `compile` method.
