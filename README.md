<div align="center">
  <img src="https://github.com/drabkirn/rails_base/raw/master/drabkirn-logo-120x120.png"/>
</div>

# Drabkirn Rails Base

> This repository serves as a base repository for new projects in rails that we build at Drabkirn

<!-- Add languages, CI/CD, main frameworks used from shields.io. Example -->
[![Ruby 2.7.1](https://img.shields.io/badge/Ruby-v2.7.1-green.svg)](https://www.ruby-lang.org/en/)
[![Rails 6.0.2.2](https://img.shields.io/badge/Rails-v6.0.2.2-brightgreen.svg)](https://rubyonrails.org/)
[![Rspec 3.9](https://img.shields.io/badge/RSpec-v3.9-red.svg)](http://rspec.info/)
[![Issues](https://img.shields.io/github/issues/drabkirn/rails_base.svg)](https://github.com/drabkirn/rails_base/issues)
[![Issues closed](https://img.shields.io/github/issues-closed/drabkirn/rails_base.svg)](https://github.com/drabkirn/rails_base/issues)
[![Pulls](https://img.shields.io/github/issues-pr/drabkirn/rails_base.svg)](https://github.com/drabkirn/rails_base/pulls)
[![Pulls](https://img.shields.io/github/issues-pr-closed/drabkirn/rails_base.svg)](https://github.com/drabkirn/rails_base/pulls)
[![License](https://img.shields.io/github/license/drabkirn/rails_base.svg)](https://choosealicense.com/licenses/agpl-3.0/)
[![CLA assistant](https://cla-assistant.io/readme/badge/drabkirn/rails_base)](https://cla-assistant.io/drabkirn/rails_base)

<!-- TODO: Full Description of Project goes here -->
We don't like building up the same rails project that we spin up for each new project that we build. So we made this template, where the defaults are set so we can prototype our ideas as fast as we can, then build the big picture of the project.


-----
-----

## Table of Contents
- [Steps Taken](#steps-taken)
- [Installation](#installation)
- [Contributing](#contributing)
- [Connect](#connect)

-----
-----

## Steps Taken:
<!-- TODO: Delete this section, not required for new apps. Also, delete this section from `Table of Contents` -->
1. Basic Setup:
    - New Rails Application:
      ```bash
      $ rails new bare_rails -d mysql
      ```
    - Adding the `.github` folder for Issues and Pull request templates.
    - Adding the License, Code of conduct and contributing guidelines.
    - Updating the `README.md` for basic steps and README updates along the way.
    - Cleaning the `Gemfile`, update it and then run:
      ```bash
      $ bundle i
      ```
    - Added `badges` to the `README` file.

2. Adding Testing support:
    - Added latest versions of `brakeman`, `bundler-audit`, `database_cleaner`, `simplecov`, `shoulda-matchers`, `rails-controller-testing`, `rspec-rails`, `factory_bot_rails`, `faker`. Then run:
      ```bash
      $ bundle i
      ```
    - Install Rspec:
      ```bash
      $ rails g rspec:install
      ```
    - Add `--format documentation` to `.rspec`
    - Rails generators - Not to run helpers generators in `rails g` command. See comment `Don't run un-required generations of files` in `config/application.rb` and uncomment required stuff as required.
    - In `spec/rails_helper.rb` - Added Simplecov, database cleaner, shoulda-matchers and FactoryBot:
      ```rb
      # Simple Cov
      ...

      # DB Cleaner
      ...

      # Shoulda Matchers
      ...

      # Include Factory Girl syntax to simplify calls to factories
      ...
      ```

3. Environment variables and Database support:
    - Added the `figaro` gem and installed it with:
      ```bash
      $ bundle exec figaro install
      ```
    - Setting up the `config/application-sample.yml` with initial data.
    - Rewriting `config/database.yml` file to use config variables from figaro env variables.

-----
-----

## Installation
<!-- TODO: Change these steps to mirror your repo's installation -->
1. You must have Ruby version `2.6.5` and Rails `6.0.2` installed. You can install them using [GoRails Setup Guide](https://gorails.com/setup/ubuntu/16.04).
      - You can install Rails `6.0.2` with:
        ```bash
        $ gem install rails -v 6.0.2
        ```
      - This repo uses MySQL as it's database. You can install it from above GoRails guide.
      - That's it, prequisites are now installed.

2. Clone the Repo:
    ```bash
    $ git clone https://github.com/drabkirn/rails_base.git
    ```

3. Install dependencies:
    ```bash
    $ cd rails_base
    $ bundle i
    $ yarn install --check-files
    ```

4. Rails Crendentials setup:
    - There is a `config/credentials.yml.enc` file, but this repo doesn't have the `master.key`, so delete this file:
      ```bash
      $ rm config/credentials.yml.enc
      ```
    - Create your new rails credentials:
      ```bash
      $ EDITOR=nano rails credentials:edit
      ```
    - Then press `ctrl + X`, then press `Y` and then press `Enter` to exit the `nano` editor. You don't have to change anything in your credentials, as we use `figaro` gem for our credentials. Rails credentials is only needed for `secret_key_base`

5. Setting up figaro and Database setup:
    - Copy the `config/application-sample.yml` to `config/application.yml`
      ```bash
      $ cp config/application-sample.yml config/application.yml
      ```
    - Then in your `config/application.yml`, add all your database configuration. For example:
      ```yml
      development:
        db_hostname: "localhost"
        db_username: "root"
        db_password: "12345678"
        db_name: "flowers_app_development"
      ```
    - Then setup the database:
      ```bash
      $ rails db:create
      $ rails db:migrate
      ```

6. Change the name of the Rails App:
    - Let's say your project name is `flowers_app`.
    - First, rename this folder from `rails_base` to `flowers_app`
    - Then, in `config/application.rb`, change `Line 9` from `module RailsBase` to `FlowersApp`.
      - Remember the app name must be in `PascalCase` like above.
    - In `package.json`, change the name to:
      ```js
      "name": "flowers_app",
      ```
    - In `config/cable.yml`, change `channel_prefix: rails_base_production` to:
      ```rb
      channel_prefix: flowers_app_production
      ```
    - In `CONTRIBUTING.md` and `README.md` file, change all references of `https://github.com/drabkirn/rails_base` to your own GitHub project. You can do this by finding the `https://github.com/drabkirn/rails_base` in these files and replacing it with your repo.
      - Also change all references of `Drabkirn Rails Base` or `Rails Base` to your app name.

7. Test it:
    - Run the rails server:
      ```bash
      $ rails server
      ```
    - Now visit `http://localhost:3000` and you should see default Rails page.

8. Next steps:
    - Now you can proceed build your app.
    - If you want to use React(or any other JS library) as front-end, then:
      - you'll need to disable `rails generations` of assets and templates in `config/application.rb`. Just un-comment below lines:
        ```rb
        g.assets false
        g.template_engine false
        ```
      - Run the command:
        ```bash
        $ rails webpacker:install:react
        ```
      - Then build your front-end in `app/javascript` folder.
    - You can start by running a scaffold:
      ```bash
      $ rails g scaffold Artile title:string body:text
      ```
    - Then Consider writing tests in `spec` folder.
    - Add some more badges to your `README.md` file.

-----
-----

## Contributing
<!-- TODO: Change your repo's links for respective guides -->
If you would like to contribute, please check [this contributing guide](https://github.com/drabkirn/rails_base/blob/master/CONTRIBUTING.md)

Please check [this Code of Conduct guide](https://github.com/drabkirn/rails_base/blob/master/CODE_OF_CONDUCT.md) before contributing or having any kind of discussion(issues, pull requests etc.) with the Bare Rails project!

-----

## Connect:
Need any help? Have any Questions? Or just say us hi!

1. [Drabkirn Website](https://go.cdadityang.xyz/drab)
2. [Our Blog](https://go.cdadityang.xyz/blog)
3. [Discord Server](https://go.cdadityang.xyz/discord)
4. [Twitter](https://go.cdadityang.xyz/DtwtK)
5. [Instagram](https://go.cdadityang.xyz/DinsK)