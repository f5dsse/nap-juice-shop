FROM alpine:3.10

WORKDIR /app
ADD . /app
RUN apk update && apk add jq curl

ENV KIBANA_URL=http://kibana:5601
ENV ELASTICSEARCH_URL=http://elasticsearch:9200

CMD ["/app/wait-for-elasticsearch.sh", "${ELASTICSEARCH_URL}", "--", "/app/add-f5-dashboards.sh"]