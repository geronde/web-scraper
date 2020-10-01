![coverage](https://img.shields.io/codecov/c/github/geronde/web-scraper?flag=coverage&token=5d1a0a1d-5760-4c9b-840d-7be880b7e9a1)

# Scraper

This repo is a web scraper made in ruby on rails and Nikogiri

## Installation

You need to install: (citing version I have used to develop this application)

 - Ruby, 2.5 or above
 - Rails, 6
 - docker, 19
 - docker compose, 1.26


## How to get started

- start the database by running ```cd docker && docker-compose up -d```.
- run migration by ```rails:migrate``` or rake ```db:migrate```
- The scraper is defined in scraper class, which is executed as application seed. To start, run `rails db:seed`

## running tests
This application uses `Rspec` for testing and `simplecov` for coverage

Current code coverage is ` 91.18%`
