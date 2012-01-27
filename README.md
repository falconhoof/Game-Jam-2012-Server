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

### GET requests

#### Is the API up?

    falconhoof.heroku.com/api/v1/

#### Get the top 20 high scores

    falconhoof.heroku.com/api/v1/scores

#### Get the highest score for a particular user

    falconhoof.heroku.com/api/v1/scores/:user

#### Get the global game stats

    falconhoof.heroku.com/api/v1/stats

#### Get the stats recorded for a particular user

    falconhoof.heroku.com/api/v1/stats/:user

### POST requests

#### Report a new high score

    falconhoof.heroku.com/api/v1/scores

Takes the following parameters:

* username
* email (optional)
* score

Example response:

    `[{"id":25,"user":"leereilly1234","score":100}]`

## Notes

### Create a user

    curl -d "username=leereilly&email=lee@leereilly.net&score=100" http://localhost:9393/api/v1/scores

