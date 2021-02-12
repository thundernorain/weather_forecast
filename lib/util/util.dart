import 'package:intl/intl.dart';

class Util{
  //  AppId from openweathermap.org
  static String appId = "56258f4104cfc740598177c55e5e5ce6";

  static String getDateFormat(DateTime dateTime) => DateFormat('EEEE, MMM d, y').format(dateTime);

  static String getTime(DateTime dateTime) => DateFormat.Hm().format(dateTime);

  static String convertTemperature(double temp) => (temp - 273).toStringAsFixed(0);
}