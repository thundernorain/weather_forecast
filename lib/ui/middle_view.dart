import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather_forecast_five_days.dart';
import 'package:weather_forecast/util/util.dart';

class MiddleView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastFD> snapshot;

  const MiddleView({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateToday = Util.getDateFormat(
        DateTime.fromMillisecondsSinceEpoch(snapshot.data.list[0].dt * 1000));

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                    "${snapshot.data.city.name}, ${snapshot.data.city.country}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("$dateToday")
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            "${Util.convertTemperature(snapshot.data.list[0].main.temp)}°C",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text("${snapshot.data.list[0].weather[0].description}",
              style: TextStyle(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Wind: ${snapshot.data.list[0].wind.speed} m/s"),
                Text("Humidity: ${snapshot.data.list[0].main.humidity}%"),
              ],
            ),
          )
        ],
      ),
    );
  }
}