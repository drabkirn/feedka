<div align="center">
  <img src="https://github.com/drabkirn/feedka/raw/master/drabkirn-logo-120x120.png"/>
</div>

# Drabkirn Feedka

<!-- DONE: Add statement -->
> Get authentic, kindful, and constructive feedback from your friends, family, and co-workers.

<!-- DONE: Add languages, CI/CD, main frameworks used from shields.io. Example -->
[![Ruby 2.7.1](https://img.shields.io/badge/Ruby-v2.7.1-green.svg)](https://www.ruby-lang.org/en/)
[![Rails 6.0.2.2](https://img.shields.io/badge/Rails-v6.0.2.2-brightgreen.svg)](https://rubyonrails.org/)
[![Rspec 4.0](https://img.shields.io/badge/RSpec-v4.0-red.svg)](http://rspec.info/)
[![Build Status](https://travis-ci.org/drabkirn/feedka.svg?branch=master)](https://travis-ci.org/drabkirn/feedka)
[![Test Coverage](https://api.codeclimate.com/v1/badges/914eb5f6039700faec09/test_coverage)](https://codeclimate.com/github/drabkirn/feedka/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/914eb5f6039700faec09/maintainability)](https://codeclimate.com/github/drabkirn/feedka/maintainability)
[![Technical Dept](https://img.shields.io/codeclimate/tech-debt/drabkirn/feedka)](https://codeclimate.com/github/drabkirn/feedka/trends/technical_debt)
[![Issues](https://img.shields.io/github/issues/drabkirn/feedka.svg)](https://github.com/drabkirn/feedka/issues)
[![Issues closed](https://img.shields.io/github/issues-closed/drabkirn/feedka.svg)](https://github.com/drabkirn/feedka/issues)
[![Pulls](https://img.shields.io/github/issues-pr/drabkirn/feedka.svg)](https://github.com/drabkirn/feedka/pulls)
[![Pulls](https://img.shields.io/github/issues-pr-closed/drabkirn/feedka.svg)](https://github.com/drabkirn/feedka/pulls)
[![License](https://img.shields.io/github/license/drabkirn/feedka.svg)](https://choosealicense.com/licenses/agpl-3.0/)
[![CLA assistant](https://cla-assistant.io/readme/badge/drabkirn/feedka)](https://cla-assistant.io/drabkirn/feedka)
[![Dependabot](https://badgen.net/dependabot/drabkirn/feedka?icon=dependabot)]()
[![Code size](https://img.shields.io/github/languages/code-size/drabkirn/feedka)]()

<!-- DONE: Full description -->
Feedka is an open-source web application that can serve as a platform to get feedback from your friends, family, and co-workers. We're all on the same boat in just our own different ocean. Let us all get better together.

<!-- DONE: Add website link here -->
**[Visit website here](https://go.cdadityang.xyz/feedka)**

-----
-----

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Contributing](#contributing)
- [Connect](#connect)

-----
-----

## Features
- Built with [Desityle UI](https://go.cdadityang.xyz/style)
- Two Factor Authentication
- Anonymous feedbacks
- Built-in moderation with AI API's
- Server side encryption to all feedbacks
- See all feature set on our [Website](https://go.cdadityang.xyz/feedka)

-----
-----

## Installation
<!-- TODO: Change these steps to mirror your repo's installation -->
1. For docker quick-start:
    - First, clone our repository and then `cd` into it:
        ```bash
        $ git clone https://github.com/drabkirn/feedka.git
        
        $ cd feedka
        ```
    - Setting up the environmental variables with Figaro: Copy the `config/application-sample.yml` to `config/application.yml`
        ```bash
        $ cp config/application-sample.yml config/application.yml
        ```
    - We have `docker-compose.yml` and corresponding `Dockerfile` in the repo which will configure gems, redis server, MYSQL DB and webpacker. All you've to do is just run few commands:
        ```bash
        $ docker-compose build

        $ docker-compose run web rails db:setup

        $ docker-compose run web rails db:migrate

        $ docker-compose run web bundle exec rake assets:precompile

        $ docker-compose up
        ```
    - If the `docker-compose run web rails db:setup` command fails, then wait for 30 seconds and retry. This happens because `mysql` image takes little time to load.
    - Now you can see your app running on `http://localhost:3000` or `http://YOUR_IP:PORT`

**More indepth instructions - Coming soon!**

-----
-----

## Contributing
<!-- TODO: Change your repo's links for respective guides -->
If you would like to contribute, please check [this contributing guide](https://github.com/drabkirn/feedka/blob/master/CONTRIBUTING.md)

Please check [this Code of Conduct guide](https://github.com/drabkirn/feedka/blob/master/CODE_OF_CONDUCT.md) before contributing or having any kind of discussion(issues, pull requests etc.) with the Feedka project!

-----

## Connect:
Need any help? Have any Questions? Or just say us hi!

1. [Drabkirn Website](https://go.cdadityang.xyz/drab)
2. [Our Blog](https://go.cdadityang.xyz/blog)
3. [Discord Server](https://go.cdadityang.xyz/discord)
4. [Twitter](https://go.cdadityang.xyz/DtwtK)
5. [Instagram](https://go.cdadityang.xyz/DinsK)