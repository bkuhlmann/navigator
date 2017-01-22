# v2.2.0 (2017-01-22)

- Updated Rubocop Metrics/LineLength to 100 characters.
- Updated Rubocop Metrics/ParameterLists max to three.
- Updated Travis CI configuration to use latest RubyGems version.
- Updated gemspec to require Ruby 2.4.0 or higher.
- Updated to Rubocop 0.47.
- Updated to Ruby 2.4.0.
- Removed Rubocop Style/Documentation check.

# v2.1.0 (2016-12-18)

- Fixed Rakefile support for RSpec, Reek, Rubocop, and SCSS Lint.
- Updated Travis CI configuration to use defaults.
- Updated to Gemsmith 8.2.x.
- Updated to Rake 12.x.x.
- Updated to Rubocop 0.46.x.
- Updated to Ruby 2.3.2.
- Updated to Ruby 2.3.3.

# v2.0.0 (2016-11-14)

- Fixed Rakefile to safely load Gemsmith tasks.
- Fixed contributing guideline links.
- Added "pg" gem development dependency. 2 hours ago.
- Added Code Climate engine support.
- Added GitHub issue and pull request templates.
- Added IRB development console Rake task support.
- Added Reek support.
- Added Rubocop Style/SignalException cop style.
- Added Ruby 2.3.0 frozen string literal support.
- Added SASS and Slim development gems.
- Added Travis CI PostgreSQL setup.
- Added `Gemfile.lock` to `.gitignore`.
- Added bond, wirb, hirb, and awesome_print development dependencies.
- Added dummy application.
- Added frozen string literal pragma.
- Updated GitHub issue and pull request templates.
- Updated README secure gem install documentation.
- Updated README to mention "Ruby" instead of "MRI".
- Updated README versioning documentation.
- Updated RSpec temp directory to use Bundler root path.
- Updated Rubocop PercentLiteralDelimiters and AndOr styles.
- Updated gem dependencies.
- Updated gemspec with conservative versions.
- Updated to Code Climate Test Reporter 1.0.0.
- Updated to Code of Conduct, Version 1.4.0.
- Updated to Gemsmith 7.7.0.
- Updated to Rails 5.0.0.
- Updated to Rubocop 0.44.
- Updated to Ruby 2.2.4.
- Updated to Ruby 2.3.0.
- Updated to Ruby 2.3.1.
- Removed CHANGELOG.md (use CHANGES.md instead).
- Removed RSpec default monkey patching behavior.
- Removed Rake console task.
- Removed Ruby 2.1.x and 2.2.x support.
- Removed gemspec description.
- Removed legacy dummy application.
- Removed rb-fsevent development dependency from gemspec.
- Removed terminal notifier gems from gemspec.
- Refactored RSpec spec helper configuration.
- Refactored gemspec to use default security keys.
- Refactored version label method name.

# v1.4.0 (2015-12-02)

- Fixed README URLs to use HTTPS schemes where possible.
- Fixed README test command instructions.
- Added Gemsmith development support.
- Added Identity module description.
- Added Patreon badge to README.
- Added Rubocop support.
- Added [pry-state](https://github.com/SudhagarS/pry-state) support.
- Added project name to README.
- Added table of contents to README.
- Updated Code Climate to run when CI ENV is set.
- Updated Code of Conduct 1.3.0.
- Updated README with Tocer generated Table of Contents.
- Updated RSpec support kit with new Gemsmith changes.
- Updated to Ruby 2.2.3.
- Updated README with SVG icons.
- Removed GitTip badge from README.
- Removed unnecessary exclusions from .gitignore.

# v1.3.0 (2015-07-05)

- Removed JRuby support (no longer officially supported).
- Fixed secure gem installs (new cert has 10 year lifespan).
- Updated to Ruby 2.2.2.

# v1.2.0 (2015-04-11)

- Added tag activator search value regular expression support.

# v1.1.0 (2015-04-01)

- Fixed bug where menu item would lose original class when active.
- Added HTML button tag support.
- Added HTML div tag support.
- Added HTML form tag support.
- Added HTML header tag support.
- Added HTML img tag support.
- Added HTML input tag support.
- Added HTML label tag support.
- Added HTML nav tag support.
- Added HTML option tag support.
- Added HTML select tag support.
- Added `Menu#image` support.
- Added `Menu#link` support.
- Added code of conduct documentation.
- Updated menu items to accept optional content.
- Updated menu items to render block content.
- Updated menu links to accept optional content.
- Updated menu links to render block content.
- Updated tag prefix shared examples to account for adding and appending target values.
- Updated to Ruby 2.2.1.

# v1.0.0 (2015-01-01)

- Removed Ruby 2.0.0 support.
- Removed Rubinius support.
- Updated gemspec to add security keys unless in a CI environment.
- Updated Code Climate to run only if environment variable is present.
- Updated spec helper to comment custom config until needed.
- Updated gemspec to use RUBY_GEM_SECURITY env var for gem certs.
- Added Ruby 2.2.0 support.
- Added Rails 4.2.x support.
- Refactored source code to use keyword arguments.
- Refactored menu activator keyword argument to be `activator:`.
- Refactored common RSpec configurations to RSpec support/kit folder.

# v0.9.1 (2014-07-13)

- Fixed bug with missing "app" folder in gemspec.

# v0.9.0 (2014-07-13)

- Removed Rails 4.0.x support.
- Added Rails Engine support.
- Added stylesheet for Dummy application.

# v0.8.0 (2014-07-09)

- Added support for HTML h1-h6 tags.
- Added support for HTML section tags.
- Added support for nested HTML data attributes.

# v0.7.0 (2014-07-06)

- Removed render_navigation helper method (replaced with navigation).
- Added Code Climate test coverage support.
- Added a tag activator object for detecting which tags to activate.
- Updated to Ruby 2.1.2.
- Updated to Rails 4.1.4.
- Updated CONTRIBUTING guidelines and documentation.
- Updated Menu#add to use tag activator.
- Updated Menu#item to use tag activator.
- Updated navigation helper to accept default/custom tag activator.
- Updated navigation helper to automatically configure current path.

# v0.6.0 (2014-04-16)

- Updated to MRI 2.1.1.
- Updated to Rubinius 2.x.x.
- Updated README with --trust-policy for secure install of gem.
- Updated RSpec helper to disable GC for all specs in order to improve performance.
- Added Rails 4.1.x support.
- Added Gemnasium support.
- Added Coveralls support.

# v0.5.0 (2014-02-15)

- Updated gemspec homepage URL to use GitHub project URL.
- Added JRuby and Rubinius VM support.

# v0.4.0 (2013-12-29)

- Fixed Ruby Gem certificate requirements for package building.
- Fixed RSpec deprecation warnings for treating metadata symbol keys as true values.
- Removed UTF-8 encoding definitions - This is the default in Ruby 2.x.x.
- Removed .ruby-version from .gitignore.
- Removed Gemfile.lock from .gitignore.
- Updated to Ruby 2.1.0.
- Updated public gem certificate to be referenced from a central server.

# v0.3.0 (2013-08-12)

- Dropped Rails 3.1.x support.
- Upgraded to Rails 4.0.0.
- Switched to using 'https://rubygems.org' instead of :rubygems for gem source.
- Cleaned up RSpec spec definitions so that class and instance methods are described properly using . and # notation.
- Switched to the public_send instead of the send method where appropriate.
- Treat symbols and true values by default when running RSpec specs.
- Added .ruby-version support.
- Added pry-rescue support.
- Removed the CHANGELOG documentation from gem install.
- Added a Versioning section to the README.
- Converted from RDoc to Markdown documentation.
- Added public cert for secure install of gem.
- Switched from the pry-debugger to pry-byebug gem.
- Ignore the signing of a gem when building in a Travis CI environment.

# v0.2.0 (2013-03-18)

- Added Twitter Bootstrap navigation menu example.
- Switched gem dependency to Rails 3.x.x range.
- Added Guard support.
- Converted/detailed the CONTRIBUTING guidelines per GitHub requirements.
- Added spec focus capability.
- Added Gem Badge support.
- Added Code Climate support.
- Added Campfire notification support.
- Switched from HTTP to HTTPS when sourcing from RubyGems.
- Added Pry development support.
- Cleaned up Guard gem dependency requirements.
- Added 'tmp' directory to .gitignore.
- Cleaned up requirement path syntax.

# v0.1.0 (2012-02-04)

- Initial version.
