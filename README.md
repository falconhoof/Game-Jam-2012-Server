# Introduction

The theme for Scottish Game Jam was the image of the Ouroboros:
![Ouroboros](http://i.imgur.com/vHGog.png)

# Installation

## Local

## Heroku

# Usage

## Web Client

* falconhoof.heroku.com
* falconhoof.heroku.com/about
* falconhoof.heroku.com/instructions
* falconhoof.heroku.com/download
* falconhoof.heroku.com/contribute


## API Client

### GET request

* falconhoof.heroku.com/api/v1/
* falconhoof.heroku.com/api/v1/scores
* falconhoof.heroku.com/api/v1/scores/:user
* falconhoof.heroku.com/api/v1/stats
* falconhoof.heroku.com/api/v1/stats/:user

### POST requests

* falconhoof.heroku.com/api/v1/scores

Takes params username, score and email (optional)

RESPONSE `[{"id":25,"user":"leereilly1234","score":100}]`

## Notes

### Create a user

    curl -d "username=leereilly&email=lee@leereilly.net&score=100" http://localhost:9393/api/v1/scores

