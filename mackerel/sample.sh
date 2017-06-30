#!/bin/bash -xe

BODY=$(cat << EOS
[
  {
    "name": "Sample.foo",
    "time": $(date +%s),
    "value": 30
  }
]
EOS
)

curl -X POST https://mackerel.io/api/v0/services/IoT/tsdb \
  -H "X-Api-Key: $MACKEREL_APIKEY" \
  -H 'Content-Type: application/json' \
  -d "$BODY"
