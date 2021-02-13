import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          Stack(
            children: [
              Image(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 350,
                image: getAssetImage(snapshot),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: 300,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
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
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.wind),
                                  SizedBox(width: 7),
                                  Text("${snapshot.data.list[0].wind.speed} m/s"),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.water),
                                  SizedBox(width: 7),
                                  Text("${snapshot.data.list[0].main.humidity}%"),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AssetImage getAssetImage(AsyncSnapshot<WeatherForecastFD> snapshot) {
    String imagePath = "assets/images/sunny.jpg";
    String weather = snapshot.data.list[0].weather[0].description.toLowerCase();

    if (weather.contains("rain")) imagePath = "assets/images/rain.jpg";
    else if (weather.contains("clouds")) imagePath = "assets/images/clouds.jpg";
    else if (weather.contains("snow")) imagePath = "assets/images/snow.jpg";
    else if (weather.contains("thunderstorm")) imagePath = "assets/images/thunderstorm.jpg";

    return AssetImage(imagePath);
  }
}
