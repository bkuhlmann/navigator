# Overview

[![Gem Version](https://badge.fury.io/rb/navigator.png)](http://badge.fury.io/rb/navigator)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/navigator.png)](https://codeclimate.com/github/bkuhlmann/navigator)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/navigator.png)](http://travis-ci.org/bkuhlmann/navigator)

Enhances Rails with a DSL for menu navigation.

# Features

* A simple DSL for creating navigation menus.
* Supports sub-menus, nested tags, HTML attributes, etc.
* Supports the following HTML tags: ul, li, a, b, em, s, small, span, strong, sub, and sup.
* Provides the "item" convenience method which combines the "li" and "a" HTML tags into a single method for less typing.

# Requirements

0. Any of the following Ruby VMs:
    * [MRI 2.x.x](http://www.ruby-lang.org)
    * [JRuby 1.x.x](http://jruby.org)
    * [Rubinius 2.x.x](http://rubini.us)
0. [Ruby on Rails 4.x.x](http://rubyonrails.org).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl -Ls http://www.redalchemist.com/gem-public.pem)
    gem install navigator -P HighSecurity

...or, for an insecure install, type the following (not recommended):

    gem install navigator

Add the following to your Gemfile:

    gem "navigator"

# Usage

The following are examples using the render_navigation view helper:

## Unordered List (simple)

    render_navigation do
      item "Dashboard", "/dashboard"
      item "News", "/posts"
    end

Yields:

    <ul>
      <li><a href="/dashboard">Dashboard</a></li>
      <li><a href="/posts">Posts</a></li>
    </ul>

## Unordered List (with attributes)

    render_navigation "ul", class: "nav" do
      item "Dashboard", "/dashboard", class: "active"
      item "News", "/posts"
    end

Yields:

    <ul class="nav">
      <li class="active"><a href="/dashboard">Dashboard</a></li>
      <li><a href="/posts">Posts</a></li>
    </ul>

## Nav (with links)

    render_navigation "nav" do
      a "Dashboard", href: "/dashboard"
      a "News", href: "/posts"
    end

Yields:

    <nav>
      <a href="/dashboard">Dashboard</a>
      <a href="/posts">Posts</a>
    </nav>

## Twitter Bootstrap Dropdown

    li nil, class: "dropdown" do
      a "Manage", href: "#", class: "dropdown-toggle", "data-toggle" => "dropdown" do
        b nil, class: "caret"
      end
      ul nil, class: "dropdown-menu" do
        item "Dashboard", admin_dashboard_path
        item "Users", admin_users_path
      end
    end

Yields:

    <ul class="nav">
      <li><a href="/en-US/admin/dashboard">Dashboard</a></li>
      <li class="dropdown">
        <a data-toggle="dropdown" class="dropdown-toggle" href="#">Manage<b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="/admin/dashboard">Dashboard</a></li>
          <li><a href="/admin/users">Users</a></li>
        </ul>
      </li>
    </ul>

# Tests

To test, do the following:

0. cd to the gem root.
0. bundle install
0. bundle exec rspec spec

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

* Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
* Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
* Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Contributions

Read CONTRIBUTING for details.

# Credits

Developed by [Brooke Kuhlmann](http://www.redalchemist.com) at [Red Alchemist](http://www.redalchemist.com)

# License

Copyright (c) 2011 [Red Alchemist](http://www.redalchemist.com).
Read the LICENSE for details.

# History

Read the CHANGELOG for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).
