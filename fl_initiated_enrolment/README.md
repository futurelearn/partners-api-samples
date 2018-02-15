# FutureLearn-initiated enrolment sample

This basic Ruby on Rails application is designed to emulate the
university-hosted degree or program enrolment form in the
FutureLearn-initiated enrolment flow.

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
ruby 2.4.1p111
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

4) Add the API consumer key and shared secret provided by your Partnership
Manager or technical contact at FutureLearn to the `.env` file

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

## Creating an enrolment request

 1) In the Course Creator interface for your FutureLearn sandbox
environment, set the external enrolment URL for a degree or program
to `http://localhost:3000/apply` (where 3000 is the port number the
sample application is running on)

 2) Go to the program or degree page in the learning interface and click
the 'Join' or 'Apply button'

 3) Click 'Continue' on the consent page

 4) You should now be taken to the enrolment form in this sample
application

## Accessing the sample admin interface

To administer the enrolment requests received by the sample application,
navigate to `http://localhost:3000/admin` (where 3000 is the port number
the sample application is running on)
