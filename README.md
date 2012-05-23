# AppTap

AppTap manages service dependencies for your applications. It uses an app-local installation of homebrew to install services, and foreman to manage service processes.

## Installation

Add this line to your application's Gemfile:

    gem 'apptap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apptap

## Usage

    $ apptap init
    $ vi config/apptap.yml
    $ apptap install
    $ apptap foreman start

## Brew Warning

You'll see a message like this when you install packages from homebrew:

    Warning: /Users/jason/Code/subakva/apptap/tmp/example/.brew/bin is not in your PATH

Don't worry about it! AppTap takes care of using the correct path when it builds the Procfile.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
