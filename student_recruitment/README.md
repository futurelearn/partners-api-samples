# Student recruitment sample

This basic Ruby on Rails application is designed to demonstrate how
student recruitment webhook and API can be used to transfer student
recruitment leads from FutureLearn to a partner.

Detailed documentation of this flow and the API credentials required to
run this application are available from your Partnership Manager or
technical contact at FutureLearn.

## Pre-requisites

The system pre-requisites for this application are the same as for the
[Rails Getting Started Guide](http://guides.rubyonrails.org/getting_started.html).

In particular, you will need you need:

- The Ruby language version 2.4.2 or newer
- A working installation of the SQLite3 Database

## Running the application

1) Ensure that you have Ruby installed

```shell
$ ruby -v
ruby 2.4.2
```

2) Ensure that you have SQLite3 installed

```shell
$ sqlite3 --version
3.19.3 2017-06-27 16:48:08 2b0954060fe10d6de6d479287dd88890f1bef6cc1beca11bc6cdb79f72e2377b
```

3) Copy the `.env.sample` file in this directory to `.env`

```shell
$ cp .env.example .env
```

4) Add the API consumer key and shared secrets provided by your Partnership
Manager or technical contact at FutureLearn to the `.env` file.

5) Install the gems for the application

```shell
$ bundle install
```

6) Create the database

```shell
$ bundle exec rails db:create
```

7) Start the server

```shell
$ bundle exec rails server
```

