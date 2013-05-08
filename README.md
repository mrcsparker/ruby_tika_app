## Ruby Tika Parser

### Introduction

This is a simple frontend to the Java Tika parser command line jar / app.

It is the same as running: 

    java -server -Djava.awt.headless=true -jar tika-app-0.10.jar FileToParse.pdf

with options like --xml, --text, etc.

### Installation

To install, add ruby_tika_app to your _Gemfile_ and run `bundle install`:

    gem 'ruby_tika_app'


### Note about installation

RubyTikaApp is a pretty big gem since it includes the ruby-tika-app jarfile.
It might take a while to install.

### Usage

First, you need Java installed.  And it needs to be in your $PATH.

Then:

```ruby
require 'ruby_tika_app'

rta = RubyTikaApp.new("sample_file.pdf")

puts rta.to_xml # <xml output>

# You also get to_json, to_text, to_text_main, and to_metadata

```

### Testing

Run:

    bundle exec rspec spec/

*NOTE*: Since we are using an underlying java library to connect to external
URLs we can't use a standard mocking library.  The test suite starts a
rack-based web server.

### Contributing

Fork on GitHub and after you've committed tested patches, send a pull request.
