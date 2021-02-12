import 'package:flutter/material.dart';
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
              separatorBuilder: (context, int index) => SizedBox(width: 8),
              itemCount: snapshot.data.list.length,
              itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 240,
                    child: WeatherCard(snapshot: snapshot, index: index),
                    decoration: BoxDecoration(color: Colors.black38),
                  )),
            ),
          )
        ],
      ),
    );
  }
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
              Text("W:  ${snapshot.data.list[index].wind.speed} m/s"),
              Text("H: ${snapshot.data.list[0].main.humidity}%")
            ],
          ),
        ),
      ),
    );
  }
}
