import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/model/weather_forecast_five_days.dart';
import 'package:weather_forecast/util/util.dart';

class Network{
  Future<WeatherForecastFD> getWeatherForecast({String cityName}) async{
  /*Future<WeatherForecast> getWeatherForecast({String cityName}) async{
    String finalUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + cityName +
        "&APPID=" + AppId.appId;*/
    String finalUrl = "http://api.openweathermap.org/data/2.5/forecast?q=" + cityName + "&appid=" + Util.appId;

    final response = await get(Uri.encodeFull(finalUrl));
    print("${Uri.encodeFull(finalUrl)}");

    if(response.statusCode == 200){
      return WeatherForecastFD.fromJson(json.decode(response.body));
      //return WeatherForecast.fromJson(json.decode(response.body));
    }else{
      throw Exception("Error getting weather forecast");
    }
  }
}