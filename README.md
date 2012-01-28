# Introduction

The theme for Scottish Game Jam was the image of the Ouroboros:

![Ouroboros](http://i.imgur.com/vHGog.png)

# Installation

## Local

    git clone https://github.com/falconhoof/Game-Jam-2012-Server
    cd Game-Jam-2012-Server
    gem install bundler
    bundle install
    export DATABASE_URL=mysql://[USERNAME]:[PASSWORD]@[HOSTNAME]/[DATABASE]

## Heroku

    heroku create [APPLICATION NAME]
    heroku config:add DATABASE_URL=mysql://[USERNAME]:[PASSWORD]@[HOSTNAME]/[DATABASE]
    git push heroku master

# Usage

## API Client

### GET requests

#### Is the API up?

    curl -d falconhoof.heroku.com/api/v1/

    {"message":"Up (yer maw)"}

#### Get the top 20 high scores

    curl -d falconhoof.heroku.com/api/v1/scores

    [
        {
            "username": "davidfarrell",
            "score": 337
        },
        {
            "username": "leereilly",
            "score": 120
        },
        {
            "username": "leereilly",
            "score": 110
        },
        {
            "username": "leereilly",
            "score": 100
        }
    ]

#### Get the highest score for a particular user (not implemented)

    curl -d falconhoof.heroku.com/api/v1/scores/:user

#### Get the global game stats

    [
        {
            "key": "explosions",
            "val": 2
        },
        {
            "key": "deaths",
            "val": 37
        },
        {
            "key": "fucks_given",
            "val": 99
        }
    ]

#### Get the stats recorded for a particular user (not implemented)

    curl -d falconhoof.heroku.com/api/v1/stats/:user

### POST requests

#### Report a new high score

    falconhoof.heroku.com/api/v1/scores

Takes the following parameters:

* username
* email (optional)
* score

Example request:
    curl -d "username=leereilly&email=lee@leereilly.net&score=100" http://falconhoof.heroku.com/api/v1/scores

Example response:

    [{"id":25,"user":"leereilly1234","score":100}]

#### Report new game stats

    falconhoof.heroku.com/api/v1/stats

Example request:

    curl -d "explosions=2&deaths=37&fucks_given=99" http://falconhoof.heroku.com/api/v1/stats/

Example response:

    [
        {
            "key": "explosions",
            "val": 2
        },
        {
            "key": "deaths",
            "val": 37
        },
        {
            "key": "fucks_given",
            "val": 99
        }
    ]

Takes the following parameters:

* all of things (literally)
  * falconhoof.heroku.com/api/v1/stats/explosions=37&death=42&[some_stat]=[some_integer_to_INCREMENT_a_counter]

Example response:

    `[{"explosions":100}, {"dicks":100}, {"problems":99}]`

## Web Client

* falconhoof.heroku.com
* falconhoof.heroku.com/statistics
* falconhoof.heroku.com/high_scores

## Notes

### Create a user

    curl -d "username=leereilly&email=lee@leereilly.net&score=100" http://falconhoof.heroku.com/api/v1/scores

### Create some stats

    curl -d "explosions=2&deaths=37&fucks_given=99" http://falconhoof.heroku.com/api/v1/stats/

# LIMITATIONS

## GLOBAL STATISTICS

* Support for integer values stats only right now. When you report a stat *name* for the first time, it is created and the counter is set to the value provided. Subsequent calls to the named stat **increments** the counter value by the value provided.

## MISC

* No security built around the API
* Database hosted outside Heroku on a shared Dreamhost server <- single point of failure