import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_forecast/model/weather_forecast_five_days.dart';
import 'package:weather_forecast/util/util.dart';

class BottomView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastFD> snapshot;

  const BottomView({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Weather forecast:".toUpperCase(),
              style: TextStyle(color: Colors.grey, fontSize: 16)),
          Container(
            height: 250,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, int index) => SizedBox(width: 12),
              itemCount: snapshot.data.list.length,
              itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 240,
                    child: WeatherCard(snapshot: snapshot, index: index),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [getWeatherCardColor(snapshot, index), Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      )
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

Color getWeatherCardColor(AsyncSnapshot<WeatherForecastFD> snapshot, int index) {
  String weather = snapshot.data.list[index].weather[0].description.toLowerCase();
  Color color = Colors.black38;

  if(weather.contains("snow")) color = Colors.lightBlue[100];
  else if(weather.contains("clouds")) color = Colors.blue;
  else if(weather.contains("sky")) color = Colors.orange;

  return color;
}

class WeatherCard extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastFD> snapshot;
  final int index;

  const WeatherCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateInCard = Util.getDateFormat(DateTime.fromMillisecondsSinceEpoch(
        snapshot.data.list[index].dt * 1000));
    //  Deleting the year from date
    dateInCard = dateInCard.split(',')[0] + ", " + dateInCard.split(',')[1];
    String timeInCard = Util.getTime(DateTime.fromMillisecondsSinceEpoch(
        snapshot.data.list[index].dt * 1000));

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$dateInCard" + "\n$timeInCard",
                  textAlign: TextAlign.center),
              Text(
                  "${Util.convertTemperature(snapshot.data.list[index].main.temp)}°C",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text("${snapshot.data.list[index].weather[0].description}",
                  style: TextStyle(fontSize: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.wind),
                  SizedBox(width: 7),
                  Text("${snapshot.data.list[index].wind.speed} m/s"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.water),
                  SizedBox(width: 7),
                  Text("${snapshot.data.list[index].main.humidity}%"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
