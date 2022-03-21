#!/bin/bash -e

ENV_REGEX="^[d,p]$"

if [[ -z $1 || ! $1 =~ $ENV_REGEX ]]; then
    echo "First parameter must specify environment: d|p"
    exit 1
fi

API=""
AUTH=""
ENV=""

if [[ $1 == 'd' ]]; then
    API="http://big-todo-api-d.eba-tvmneqax.us-east-1.elasticbeanstalk.com"
    AUTH="http://big-todo-auth-d.eba-vwxrnf4w.us-east-1.elasticbeanstalk.com"
    ENV="Development"
fi

if [[ -z $API || -z $AUTH || -z $ENV ]]; then
    echo "One of the variables wasnt set!"
    exit 1
fi

cat <<EOF > .env
API=$API
AUTH=$AUTH
ENV=$ENV
EOF