KIBANA_URL=http://kibana:5601
ELASTICSEARCH_URL=http://elasticsearch:9200

# Not working, need to figure out how to retry until yellow status returned before moving on to POST dashboard json
curl -XGET "$ELASTICSEARCH_URL/_cluster/health?wait_for_status=yellow&timeout=50s&pretty"

jq -s . overview-dashboard.ndjson | jq '{"objects": . }' | \
curl -k --location --request POST "$KIBANA_URL/api/kibana/dashboards/import" \
    --header 'kbn-xsrf: true' \
    --header 'Content-Type: text/plain' -d @- \
    | jq

jq -s . false-positives-dashboards.ndjson | jq '{"objects": . }' | \
curl -k --location --request POST "$KIBANA_URL/api/kibana/dashboards/import" \
    --header 'kbn-xsrf: true' \
    --header 'Content-Type: text/plain' -d @- \
    | jq
