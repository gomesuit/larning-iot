function postTemp(temp){
  var date = new Date() ;

  var payload = [
    {
      "name" : "Sensor.temp",
      "time" : Math.floor( date.getTime() / 1000 ),
      "value" : temp
    }
  ];

  Logger.log(JSON.stringify(payload));

  var headers =
      {
        "X-Api-Key" : "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
        "Content-Type" : "application/json"
      };

  var options =
      {
        "method" : "post",
        "headers" : headers,
        "payload" : JSON.stringify(payload)
      };

  UrlFetchApp.fetch("https://mackerel.io/api/v0/services/IoT/tsdb", options);
}

function getTemp(){
  var url = 'https://us.wio.seeed.io/v1/node/GroveTempHumD0/temperature?access_token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  var response = UrlFetchApp.fetch(url);
  var jsonResponse = response.getContentText("UTF-8");
  var json = JSON.parse(jsonResponse);
  Logger.log(json.celsius_degree);
  return json.celsius_degree;
}

function myFunction(){
  var temp = getTemp();
  postTemp(temp);
}
