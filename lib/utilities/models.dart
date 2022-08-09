import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  final int? max;
  final int? min;
  final int? current;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidity;
  final int? chanceRain;
  final String? image;
  final String? time;
  final String? location;

  Weather(
      {this.max,
      this.min,
      this.name,
      this.day,
      this.wind,
      this.humidity,
      this.chanceRain,
      this.image,
      this.current,
      this.time,
      this.location});
}

const String apiKey = "45865970ebbfbc127eb2a16dd7f753e7";

Future<List> fetchData(String lat, String lon, String city) async {
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$apiKey";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);

    
    var current = res["current"];
    Weather currentTemp = Weather(
      current: current["temp"]?.round() ?? 0,
      name: current["weather"][0]["main"].toString(),
      day: DateFormat("EEEE dd MMMM").format(date),
      wind: current["wind_speed"]?.round() ?? 0,
      humidity: current["humidity"]?.round() ?? 0,
      chanceRain: current["uvi"]?.round() ?? 0,
      location: city,
      image: current["weather"][0]["icon"].toString(),
    );

    List<Weather> todayWeather = [];

    int hour = int.parse(DateFormat("HH").format(date));
    for (int i = 0; i < 4; i++) {
      var temp = res["hourly"];
      var hourly = Weather(
          current: temp[i]["temp"]?.round() ?? 0,
          image: temp[i]["weather"][0]["icon"].toString(),
          time: "${Duration(hours: hour + (i + 1)).toString().split(":")[0]}:00");
      todayWeather.add(hourly);
    }

    // tomorrwow's weather
    var daily = res["daily"][0];
    Weather tomorrowTemp = Weather(
        max: daily["temp"]["max"]?.round() ?? 0,
        min: daily["temp"]["min"]?.round() ?? 0,
        image: daily["weather"][0]["icon"].toString(),
        name: daily["weather"][0]["main"].toString(),
        wind: daily["wind_speed"]?.round() ?? 0,
        humidity: daily["rain"]?.round() ?? 0,
        chanceRain: daily["uvi"]?.round() ?? 0);

    // 7 days
    List<Weather> sevenDays = [];
    for (int i = 0; i < 8; i++) {
      String day = DateFormat("EEEE")
          .format(DateTime(date.year, date.month, date.day + (i + 1)))
          .substring(0, 3);
      var temp = res["daily"][i];
      var hourly = Weather(
        max: temp["temp"]["max"]?.round() ?? 0,
        min: temp["temp"]["min"]?.round() ?? 0,
        image: temp["weather"][0]["icon"].toString(),
        name: temp["weather"][0]["main"].toString(),
        day: day,
      );
      sevenDays.add(hourly);
    }
    return [currentTemp, todayWeather, tomorrowTemp, sevenDays];
  }

  return [null, null, null, null];
}
