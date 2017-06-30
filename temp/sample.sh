#!/bin/bash -xe

function temp(){
  curl -sS "https://us.wio.seeed.io/v1/node/GroveTempHumD0/temperature?access_token=$ACCESS_TOKEN" | jq '.celsius_degree'
}

TEMP=$(temp)

if [ $TEMP = null ]; then
  exit 1
fi

BODY=$(cat << EOS
[
  {
    "name": "Sensor.temp",
    "time": $(date +%s),
    "value": $TEMP
  }
]
EOS
)

curl -X POST https://mackerel.io/api/v0/services/IoT/tsdb \
  -H "X-Api-Key: $MACKEREL_APIKEY" \
  -H 'Content-Type: application/json' \
  -d "$BODY"
