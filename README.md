# Overview

[![Gem Version](https://badge.fury.io/rb/navigator.png)](http://badge.fury.io/rb/navigator)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/navigator.png)](https://codeclimate.com/github/bkuhlmann/navigator)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/navigator/coverage.png)](https://codeclimate.com/github/bkuhlmann/navigator)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/navigator.png)](https://gemnasium.com/bkuhlmann/navigator)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/navigator.png)](http://travis-ci.org/bkuhlmann/navigator)
[![Gittip](http://img.shields.io/gittip/bkuhlmann.svg)](https://www.gittip.com/bkuhlmann)

Enhances Rails with a DSL for menu navigation.

# Features

* Provides a simple DSL for building navigation menus.
* Supports auto-detection/highlighting of active menu items based on current path (customizable for non-path usage too).
* Supports sub-menus, nested tags, HTML attributes, etc.
* Supports the following HTML tags: nav, ul, li, a, b, em, s, small, span, strong, sub, and sup.
* Provides an "item" convenience method which combines the "li" and "a" HTML tags into a single method for less typing.

# Requirements

0. Any of the following Ruby VMs:
    * [MRI 2.x.x](http://www.ruby-lang.org)
    * [JRuby 1.x.x](http://jruby.org)
    * [Rubinius 2.x.x](http://rubini.us)
0. [Ruby on Rails 4.x.x](http://rubyonrails.org).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl -Ls http://www.alchemists.io/gem-public.pem)
    gem install navigator --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification while
allowing the installation of unsigned dependencies since they are beyond the scope of this gem.

For an insecure install, type the following (not recommended):

    gem install navigator

Add the following to your Gemfile:

    gem "navigator"

# Usage

The following are examples using the navigation view helper:

## Unordered List (simple)

Code:

    navigation do
      item "Dashboard", "/dashboard"
      item "News", "/posts"
    end

Result:

    <ul>
      <li><a href="/dashboard">Dashboard</a></li>
      <li><a href="/posts">Posts</a></li>
    </ul>

## Unordered List (with attributes)

Code:

    navigation "ul", class: "nav" do
      item "Dashboard", "/dashboard", class: "active"
      item "News", "/posts"
    end

Result:

    <ul class="nav">
      <li class="active"><a href="/dashboard">Dashboard</a></li>
      <li><a href="/posts">Posts</a></li>
    </ul>

## Unordered List (with multiple data attributes)

Code:

    navigation do
      item "Home", "/home", data: {id: 1, type: "public"}
    end

Result:

    <ul>
      <li data-id="1" data-type="public"><a href="/home">Home</a></li>
    </ul>

*TIP: Nested data-* attributes can be applied to any menu item in the same manner as Rails view helpers.*

## Nav (with links)

Code:

    navigation "nav" do
      a "Dashboard", href: "/dashboard"
      a "News", href: "/posts"
    end

Result:

    <nav>
      <a href="/dashboard">Dashboard</a>
      <a href="/posts">Posts</a>
    </nav>

## Foundation Menu

Code:

    navigation "nav", class: "top-bar", "data-topbar" => nil do
      ul nil, class: "title-area" do
        li nil, class: "name" do
          h1 do
            a "Demo", href: "/home"
          end
        end
      end

      section nil, class: "top-bar-section" do
        ul nil, class: "left" do
          item "Home", "/"
          item "About", "/about"
        end

        ul nil, class: "right" do
          item "v1.0.0", '#'
        end

        ul nil, class: "right" do
          item "Login", login_path, {}, {class: "button tiny round"}
        end
      end
    end

Result:

    <nav class="top-bar" data-topbar="">
      <ul class="title-area">
        <li class="name">
          <h1><a href="/" class="active">Demo</a></h1>
        </li>
      </ul>

      <section class="top-bar-section">
        <ul class="left">
          <li class="active"><a href="/">Home</a></li>
          <li><a href="/about">About</a></li>
        </ul>

        <ul class="right">
          <li><a href="#">v1.0.0</a></li>
        </ul>

        <ul class="right">
          <li><a class="button tiny round" href="/login">Login</a></li>
        </ul>
      </section>
    </nav>

## Bootstrap Dropdown

Code:

    navigation "nav" do
      item "Dashboard", admin_dashboard_path
      li nil, class: "dropdown" do
        a "Manage", href: "#", class: "dropdown-toggle", "data-toggle" => "dropdown" do
          b nil, class: "caret"
        end
        ul nil, class: "dropdown-menu" do
          item "Dashboard", admin_dashboard_path
          item "Users", admin_users_path
        end
      end
    end

Result:

    <ul class="nav">
      <li><a href="/admin/dashboard">Dashboard</a></li>
      <li class="dropdown">
        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
          Manage
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">
          <li><a href="/admin/dashboard">Dashboard</a></li>
          <li><a href="/admin/users">Users</a></li>
        </ul>
      </li>
    </ul>

# Customization

The `navigation` view helper can accept an optional `Navigator::TagActivator` instance. Example:

    # Code
    activator = Navigator::TagActivator.new search_value: request.env["PATH_INFO"]
    navigation "nav", {}, activator do
      a "Home", href: home_path
      a "About", href: about_path
    end

    <!-- Result -->
    <nav>
      <a href="/home" class="active">Home</a>
      <a href="/about" class="active">About</a>
    </nav>

This is the default behavior for all navigation menus and is how menu items automaticaly get the "active" class when the
item URL (in this case "/home") matches the `request.env[“PATH_INFO"]` to indicate current page/active tab.

`Navigator::TagActivator` instances can be configured as follows:

* search_key = Optional. The HTML tag attribute to search for. Default: :href.
* search_value = Required. The value to match against the search_key value in order to update the value of the
  target_key. Default: nil.
* target_key = Optional. The HTML tag attribute key value to update when the search_value and search_key value match.
  Default:
  :class.
* target_value = Optional. The value to be applied to the target_key value. If no value exists, then the value is added.
  Otherwise, if a value exists then the value is appended to the existing value. Default: "active".

This customization allows for more sophisticated detection/updating of active HTML tags. For example, the example code
(above) could be rewritten to use `data-*` attributes and customized styles as follows:

    # Code
    activator = Navigator::TagActivator.new search_key: "data-id",
                                            search_value: "123",
                                            target_key: "data-style"
                                            target_value: "current"

    navigation "nav", {}, activator do
      a "Home", href: home_path, "data-id" => "123", data-style="info"
      a "About", href: about_path, "data-id" => "789"
    end

    <!-- Result -->
    <nav>
      <a href="/home" data-id="123" data-style="info current">Home</a>
      <a href="/about" data-id="789">About</a>
    </nav>

# Tests

To test, run:

    bundle exec rspec spec

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

* Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
* Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
* Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# Credits

Developed by [Brooke Kuhlmann](http://www.alchemists.io) at [Alchemists](http://www.alchemists.io)

# License

Copyright (c) 2012 [Alchemists](http://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).
