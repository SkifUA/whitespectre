# README

* Ruby version 2.6.5
* Rails 5.2.6
* Database PostgreSQL

## TASK:

Imagine we’ve been working with a company who produces a wearable device to measure body temperature (to predict onset of illness). We need to store that data in the Rails backend. There is also a device-specific temperature “offset” value which, when summed with the raw reading from the device will give the actual temperature value. This offset may change over time.

Using Rails + database, please design and build a REST API interface to a) set offset and b) store temperature readings for a user and c) list historical data readings. The system should send a simple alert email if the temperature appears to be trending to exceed 37.5C. For the purpose of this exercise, assume that trending means that the last 5 readings are getting closer to the threshold.

Please write appropriate tests with rspec. Document your design decisions to explain your thinking. For the purposes of this exercise, ignore auth.

## Install
* `bundle install`
* `rails db:create`
* `rails db:migration`
* `rails db:seed`

## Endpoints

* add temperature POST /devices/:device_id/temperatures
* set offset: PUT devices/:id
* store temperature readings for a user: by user GET /users/:id
* list historical data readings: by device GET /devices/:device_id/temperatures