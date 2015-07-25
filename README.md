# Navigator

[![Gem Version](https://badge.fury.io/rb/navigator.png)](http://badge.fury.io/rb/navigator)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/navigator.png)](https://codeclimate.com/github/bkuhlmann/navigator)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/navigator/coverage.png)](https://codeclimate.com/github/bkuhlmann/navigator)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/navigator.png)](https://gemnasium.com/bkuhlmann/navigator)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/navigator.png)](http://travis-ci.org/bkuhlmann/navigator)
[![Gittip](http://img.shields.io/gittip/bkuhlmann.svg)](https://www.gittip.com/bkuhlmann)

Enhances Rails with a DSL for menu navigation.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
    - [Unordered List (simple)](#unordered-list-simple)
    - [Unordered List (with attributes)](#unordered-list-with-attributes)
    - [Unordered List (with multiple data attributes)](#unordered-list-with-multiple-data-attributes)
    - [Nav (with links)](#nav-with-links)
    - [Foundation Menu](#foundation-menu)
    - [Bootstrap Dropdown](#bootstrap-dropdown)
    - [Menu Helpers](#menu-helpers)
- [Customization](#customization)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Features

- Provides a DSL for building navigation menus.
- Supports auto-detection/highlighting of active menu items based on current path (customizable for non-path usage too).
- Supports sub-menus, nested tags, HTML attributes, etc.
- Supports the following HTML tags:
    - div
    - section
    - header
    - h1 - h6
    - nav
    - ul
    - li
    - a
    - img
    - b
    - em
    - s
    - small
    - span
    - strong
    - sub
    - sup
    - form
    - label
    - select
    - option
    - input
    - button
- Provides `link`, `image`, and `item` convenience methods for succinct ways to build commonly used menu elements.

# Requirements

0. [MRI 2.x.x](http://www.ruby-lang.org).
0. [Ruby on Rails 4.1.x](http://rubyonrails.org).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl -Ls https://www.alchemists.io/gem-public.pem)
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

    navigation "ul", attributes: {class: "nav"} do
      item "Dashboard", "/dashboard", item_attributes: {class: "active"}
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
      item "Home", "/home", item_attributes: {data: {id: 1, type: "public"}}
    end

Result:

    <ul>
      <li data-id="1" data-type="public"><a href="/home">Home</a></li>
    </ul>

*TIP: Nested data-- attributes can be applied to any menu item in the same manner as Rails view helpers.*

## Nav (with links)

Code:

    navigation "nav" do
      a "Dashboard", attributes: {href: "/dashboard"}
      a "News", attributes: {href: "/posts"}
    end

Result:

    <nav>
      <a href="/dashboard">Dashboard</a>
      <a href="/posts">Posts</a>
    </nav>

## Foundation Menu

Code:

    navigation "nav", attributes: {class: "top-bar", "data-topbar" => nil} do
      ul attributes: {class: "title-area"} do
        li attributes: {class: "name"} do
          h1 do
            a "Demo", attributes: {href: "/home"}
          end
        end
      end

      section attributes: {class: "top-bar-section"} do
        ul attributes: {class: "left"} do
          item "Home", "/"
          item "About", "/about"
        end

        ul attributes: {class: "right"} do
          item "v1.0.0", '#'
        end

        ul attributes: {class: "right"} do
          item "Login", "/login", link_attributes: {class: "button tiny round"}
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
      li attributes: {class: "dropdown"} do
        a "Manage", attributes: {href: "#", class: "dropdown-toggle", "data-toggle" => "dropdown"} do
          b attributes: {class: "caret"}
        end
        ul attributes: {class: "dropdown-menu"} do
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

## Menu Helpers

There are several convenience methods, in addition to the standard HTML tags, that can make for shorter lines of code.
The following describes each:

When building links, the default is:

      navigation "nav", activator: activator do
        a "Home", attributes: {href: home_path}
      end

...but can be written as:

      navigation "nav", activator: activator do
        link "Home", home_path
      end

When building images, the default is:

      navigation "nav", activator: activator do
        img attributes: {src: "http://placehold.it/50x50", alt: "Example"}
      end

...but can be written as:

      navigation "nav", activator: activator do
        image "http://placehold.it/50x50", "Example"
      end

When building menu items, the default is:

      navigation "nav", activator: activator do
        li do
          a "Home", attributes: {href: home_path}
        end
      end

...but can be written as:

      navigation "nav", activator: activator do
        item "Home", "/dashboard"
      end

These are just a few, simple, examples of what can be achieved. See the specs for additional usage and customization.

# Customization

The `navigation` view helper can accept an optional `Navigator::TagActivator` instance. Example:

    # Code
    activator = Navigator::TagActivator.new search_value: request.env["PATH_INFO"]

    navigation "nav", activator: activator do
      link "Home", home_path
      link "About", about_path
    end

    <!-- Result -->
    <nav>
      <a href="/home" class="active">Home</a>
      <a href="/about" class="active">About</a>
    </nav>

This is the default behavior for all navigation menus and is how menu items automaticaly get the "active" class when the
item URL (in this case "/home") matches the `request.env[“PATH_INFO"]` to indicate current page/active tab.

`Navigator::TagActivator` instances can be configured as follows:

- search_key = Optional. The HTML tag attribute to search for. Default: :href.
- search_value = Required. The value to match against the search_key value in order to update the value of the
  target_key. Default: nil.
- target_key = Optional. The HTML tag attribute key value to update when the search_value and search_key value match.
  Default: :class.
- target_value = Optional. The value to be applied to the target_key value. If no value exists, then the value is added.
  Otherwise, if a value exists then the value is appended to the existing value. Default: "active".

This customization allows for more sophisticated detection/updating of active HTML tags. For example, the example code
(above) could be rewritten to use `data-*` attributes and customized styles as follows:

    # Code
    activator = Navigator::TagActivator.new search_key: "data-id",
                                            search_value: "123",
                                            target_key: "data-style"
                                            target_value: "current"

    navigation "nav", activator: activator do
      link "Home", home_path, attributes: {data: {id: "123", data-style="info"}}
      link "About", about_path attributes: {data: {id: "789"}}
    end

    <!-- Result -->
    <nav>
      <a href="/home" data-id="123" data-style="info current">Home</a>
      <a href="/about" data-id="789">About</a>
    </nav>

Lastly, the search value can be a *regular expression* to make things easier when dealing with complicated routes, sub-
menus, etc. Example:

      # Code
      profile_activator = Navigator::TagActivator.new search_value: /^profile.+/

      navigation do
        item "Dashboard", dashboard_path
        li activator: profile_activator do
          link "Profile", '#'

          ul do
            item "Addresses", profile_addresses_path
            item "Emails", profile_emails_path
          end
        end
      end

      <!-- Result -->
      <ul>
        <li><a href="/dashboard">Dashboard</a></li>
        <li class="active">
          <a href="#">Profile</a>
          <ul>
            <li><a href="profile/addresses">Addresses</a></li>
            <li><a href="profile/emails">Emails</a></li>
          </ul>
        </li>
      </ul>

Assuming either the `Addresses` or `Emails` menu item was clicked, the `Profile` menu item would be active due to the
regular expression (i.e. `/^profile.+/`) matching one of the the `profile/*` paths.

# Tests

To test, run:

    bundle exec rspec spec

To test the dummy application, run:

    cd spec/dummy
    bin/rails server

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2012 [Alchemists](https://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at [Alchemists](https://www.alchemists.io).
