# Puma::RuntimeEnv

Puma plugin to update ENV vars at runtime.

## Usage

This gem on its own won't do much. You'll need an adapter to read your ENV vars from a source:

- [From k8s mounted secrets](https://github.com/shaqq/puma-runtime_env-k8s)
- ~ * Your awesome adapter here * ~

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'puma-runtime_env'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puma-runtime_env

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shaqq/puma-runtime_env. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [Apache 2.0 License](https://opensource.org/licenses/Apache-2.0).

## Code of Conduct

Everyone interacting in the Puma::RuntimeEnv project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/puma-runtime_env/blob/master/CODE_OF_CONDUCT.md).
