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

#### Report new game stats

    falconhoof.heroku.com/api/v1/stats

Takes the following parameters:

* all of things (literally)
  * falconhoof.heroku.com/api/v1/stats/explosions=37&death=42&[some_stat]=[some_integer_to_INCREMENT_a_counter]

Example response:

    `[{"explosions":100}, {"dicks":100}, {"problems":99}]`

## Notes

### Create a user

    curl -d "username=leereilly&email=lee@leereilly.net&score=100" http://localhost:9393/api/v1/scores

### Create some stats

    curl -d "explosions=2&dicks=37&problems=99" http://localhost:9393/api/v1/stats/

# LIMITATIONS

## GLOBAL STATISTICS

* Support for integer values stats only right now. When you report a stat *name* for the first time, it is created and the counter is set to the value provided. Subsequent calls to the named stat **increments** the counter value by the value provided.

## MISC

* No security built around the API
* Free Heroku database is limited to 5MB, so purge often... or move the DB somewhere else