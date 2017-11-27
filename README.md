# FutureLearn-initiated enrolment sample app

This sample application is intended for use by our partners and provides a proof
of concept for integrating with the FutureLearn platform using the
FutureLearn-initiated enrolment flow.

Please speak to your partnership manager in order to receive your authentication
credentials and gain access to the relevant API documentation.

## How to get started

1. Install the required gems: `bundle install`
2. Create the database: `bundle exec rails db:create`
3. Start the server `bundle exec rails server`

Note that you will need to set the following environment variables before
starting up the server:

- `API_CONSUMER_KEY` e.g `sample-uni.test`
- `API_SHARED_SECRET`
- `API_BASE_URL` e.g. `https://sandbox-degrees-api.futurelearn.com/partners`
