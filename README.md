[![Build Status](https://travis-ci.com/gdubin/uls.svg?branch=main)](https://travis-ci.com/gdubin/uls) [![codecov](https://codecov.io/gh/gdubin/uls/branch/master/graph/badge.svg)](https://codecov.io/gh/gdubin/uls)

# ULS

This gem is used for parsing the database/files from the FCC Universal Licensing System.  These files are often relevant to amateur radio enthusiasts.

You may download the source files from the FCC by visiting the [Universal Licensing System Databases](http://wireless.fcc.gov/uls/index.htm?job=transaction&page=weekly) page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uls'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install uls

## Usage

##### Configuration

Configuration of various options are available via the base ULS module.  To configure ULS related settings:

```
ULS.configure do |config|
  config.tmpdir = '/your/tmpdir/here'
end
```

The options currently available are as follows:

|option|default|description|
|------|-------|-----------|
|tmpdir|Dir.tmpdir|A location for ULS database files to be downloaded to and unpacked.  Defaults to whatever the [Dir#tmpdir](https://ruby-doc.org/stdlib-2.5.3/libdoc/tmpdir/rdoc/Dir.html#method-c-tmpdir) is set to for your system.|

##### Retrieving Databases

The FCC splits their data into several categories.  Each category is represented as a class method on `ULS::Retriever`.  From there, you may select either the daily or weekly file for a specific types.  Types are driven by the category but for most categories the types are `applications` or `licenses`.

For example, to download the entire license database for amateur radio:

```
database = ULS::Retriever.amateur_radio.weekly(:licenses)
```

The weekly database contains all of the data and is republished weekly.  Daily database updates are also provided that are much smaller and only contain the specified day's data:

```
database = ULS::Retriever.amateur_radio.daily(:licenses)
```

The above line will download the previous day's updates.  It also takes a second parameter which corresponds to the [Date#wday](https://apidock.com/ruby/Date/wday) value.  So if you wanted to download last Tuesday's daily license file:

```
database = ULS::Retriever.amateur_radio.daily(:licenses, 2)
```

##### Parsing Databases

After you have an available database to work with, you may start interacting with the records within it:

```
database.name_and_addresses.each_record do |record|
  # do something
end
```

When you're done with a database, you can clean up the extracted files using:

```
database.clean
```

If you're completely done with this version of the database then this command will remove the zip file:

```
database.delete
```

If you want to do both:

```
database.delete!
```

The above will not only remove all the extracted files but also delete the compressed file.

There may be instances where you want to keep the source files around.  A database can be reconstructed from the filesystem by calling:

```
ULS::Database.new('/path/to/zip/or/extracted/directory')
```

You may pass the path to the zip file, or the already extracted directory, to interact with the records within.

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gdubin/uls. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ULS project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/uls/blob/master/CODE_OF_CONDUCT.md).
