#!/bin/ash

set -x

elasticsearch="$1"
kibana="$2"
shift 2
cmd="$@"

# First wait for ES to start...

until $(curl --output /dev/null --silent --head --fail "$elasticsearch"); do
    printf '.'
    sleep 1
done

response=$(curl $elasticsearch)

until [ "$response" = "200" ]; do
    response=$(curl --write-out %{http_code} --silent --output /dev/null "$elasticsearch")
    >&2 echo "Elastic Search is unavailable - sleeping"
    sleep 1
done


# next wait for ES status to turn to yellow
health="$(curl -fsSL "$elasticsearch/_cat/health?h=status")"
health="$(echo "$health" | sed -r 's/^[[:space:]]+|[[:space:]]+$//g')" # trim whitespace (otherwise we'll have "yellow ")

until [ "$health" = 'green' ]; do
    health="$(curl -fsSL "$elasticsearch/_cat/health?h=status")"
    health="$(echo "$health" | sed -r 's/^[[:space:]]+|[[:space:]]+$//g')" # trim whitespace (otherwise we'll have "yellow ")
    >&2 echo "Elastic Search is unavailable - sleeping"
    sleep 1
done

>&2 echo "Elastic Search is up"

# next wait for Kibana status to turn to yellow
health="$(curl $kibana/api/status | jq -r '.status.overall.state')"

until [ "$health" = 'green' ]; do
    health="$(curl $kibana/api/status | jq -r '.status.overall.state')"
    >&2 echo "Kibana is unavailable - sleeping"
    sleep 1
done

>&2 echo "Kibana is up"

exec $cmd