#!/bin/bash -xe

function temp(){
  curl -sS "https://us.wio.seeed.io/v1/node/GroveTempHumD0/temperature?access_token=$ACCESS_TOKEN" | jq '.celsius_degree'
}

BODY=$(cat << EOS
[
  {
    "name": "Sensor.temp",
    "time": $(date +%s),
    "value": $(temp)
  }
]
EOS
)

curl -X POST https://mackerel.io/api/v0/services/IoT/tsdb \
  -H "X-Api-Key: $MACKEREL_APIKEY" \
  -H 'Content-Type: application/json' \
  -d "$BODY"
