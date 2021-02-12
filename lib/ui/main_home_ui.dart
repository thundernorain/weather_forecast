import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/model/weather_forecast_five_days.dart';
import 'package:weather_forecast/ui/middle_view.dart';
import 'package:weather_forecast/util/network.dart';

import 'bottom_view.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Future<WeatherForecastFD> weatherForecast;
  String _cityName = "moscow";

  @override
  void initState() {
    super.initState();

    weatherForecast = getWeatherFromName(cityName: _cityName);

    weatherForecast.then(
        (value){
          print(value.city.name);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 15),
          searchBar(),
          Container(
              child: FutureBuilder<WeatherForecastFD>(
                  future: weatherForecast,
                  builder: (context, AsyncSnapshot<WeatherForecastFD> snapshot) =>
                      snapshot.hasData
                          ? weatherForecastBuilder(snapshot)
                          : processSnapshotWithoutData(snapshot: snapshot)))
        ],
      ),
    );
  }

  Widget searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Enter city name",
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.all(8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onSubmitted: (value) {
        setState(() {
          _cityName = value;
          weatherForecast = getWeatherFromName(cityName: _cityName);
        });
      },
    );
  }

  Future<WeatherForecastFD> getWeatherFromName({String cityName}) =>
      Network().getWeatherForecast(cityName: cityName);

  Widget weatherForecastBuilder(AsyncSnapshot<WeatherForecastFD> snapshot) {
    return Column(
      children: [
        MiddleView(snapshot: snapshot),
        SizedBox(height: 80),
        BottomView(snapshot: snapshot)
      ],
    );
  }

  Widget processSnapshotWithoutData(
          {AsyncSnapshot<WeatherForecastFD> snapshot}) =>
      (snapshot.hasError)
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Error getting data",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ))
          : Center(child: CircularProgressIndicator());
}
