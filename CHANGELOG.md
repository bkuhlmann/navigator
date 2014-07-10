# v0.8.0

* Added support for HTML h1-h6 tags.
* Added support for HTML section tags.
* Added support for nested HTML data attributes.

# v0.7.0

* Removed render_navigation helper method (replaced with navigation).
* Added Code Climate test coverage support.
* Added a tag activator object for detecting which tags to activate.
* Updated to Ruby 2.1.2.
* Updated to Rails 4.1.4.
* Updated CONTRIBUTING guidelines and documentation.
* Updated Menu#add to use tag activator.
* Updated Menu#item to use tag activator.
* Updated navigation helper to accept default/custom tag activator.
* Updated navigation helper to automatically configure current path.

# v0.6.0

* Updated to MRI 2.1.1.
* Updated to Rubinius 2.x.x.
* Updated README with --trust-policy for secure install of gem.
* Updated RSpec helper to disable GC for all specs in order to improve performance.
* Added Rails 4.1.x support.
* Added Gemnasium support.
* Added Coveralls support.

# v0.5.0

* Updated gemspec homepage URL to use GitHub project URL.
* Added JRuby and Rubinius VM support.

# v0.4.0

* Fixed Ruby Gem certificate requirements for package building.
* Fixed RSpec deprecation warnings for treating metadata symbol keys as true values.
* Removed UTF-8 encoding definitions - This is the default in Ruby 2.x.x.
* Removed .ruby-version from .gitignore.
* Removed Gemfile.lock from .gitignore.
* Updated to Ruby 2.1.0.
* Updated public gem certificate to be referenced from a central server.

# v0.3.0

* Dropped Rails 3.1.x support.
* Upgraded to Rails 4.0.0.
* Switched to using 'https://rubygems.org' instead of :rubygems for gem source.
* Cleaned up RSpec spec definitions so that class and instance methods are described properly using . and # notation.
* Switched to the public_send instead of the send method where appropriate.
* Treat symbols and true values by default when running RSpec specs.
* Added .ruby-version support.
* Added pry-rescue support.
* Removed the CHANGELOG documentation from gem install.
* Added a Versioning section to the README.
* Converted from RDoc to Markdown documentation.
* Added public cert for secure install of gem.
* Switched from the pry-debugger to pry-byebug gem.
* Ignore the signing of a gem when building in a Travis CI environment.

# v0.2.0

* Added Twitter Bootstrap navigation menu example.
* Switched gem dependency to Rails 3.x.x range.
* Added Guard support.
* Converted/detailed the CONTRIBUTING guidelines per GitHub requirements.
* Added spec focus capability.
* Added Gem Badge support.
* Added Code Climate support.
* Added Campfire notification support.
* Switched from HTTP to HTTPS when sourcing from RubyGems.
* Added Pry development support.
* Cleaned up Guard gem dependency requirements.
* Added 'tmp' directory to .gitignore.
* Cleaned up requirement path syntax.

# v0.1.0

* Initial version.
