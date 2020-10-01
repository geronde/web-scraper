[![Build Status](https://travis-ci.com/geronde/web-scraper.svg?token=bJuEyghgD6p1pyHy1sue&branch=master)](https://travis-ci.com/geronde/web-scraper)
[![codecov](https://codecov.io/gh/geronde/web-scraper/branch/master/graph/badge.svg?token=7KJVIDEQ7C)](https://codecov.io/gh/geronde/web-scraper)

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
