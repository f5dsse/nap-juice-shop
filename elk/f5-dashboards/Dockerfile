FROM alpine:3.10

WORKDIR /app
ADD . /app
RUN apk update && apk add jq curl

HEALTHCHECK CMD curl -fsSL "http://elasticsearch:9200/_cat/health?h=status" | grep -E '^yellow'

CMD ["sh", "/app/entrypoint.sh"]